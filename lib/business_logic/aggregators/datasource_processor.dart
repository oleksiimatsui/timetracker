import '../../helpers/date_helpers.dart';
import '../boundary_crossing_objects/database_model.dart';
import '../entities/tracking_data.dart';


/// A processor that converts the data from active stopwatches into history items
///
/// processes all the stopwatches in the [_stopwatchesRepo] datasource
/// based on their state, it modifies them and creates records in [_historyRepo]
/// - For running stopwatches, it splits the duration across multiple days if necessary,
/// adds history records and updates stopwatch duration.
/// - For completed stopwatches, it adds a single history item and clears the stopwatch duration.
class StopwatchToHistoryProcessor {
  final StopwatchDSInterface _stopwatchesRepo;
  final HistoryDSInterface _historyRepo;

  StopwatchToHistoryProcessor(this._stopwatchesRepo, this._historyRepo);

  process() async {
    var stopwatchesData = await _stopwatchesRepo.getStopwatches();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    List<HistoryItemStorageModel> historyToAdd = [];
    for (final stopwatch in stopwatchesData) {
      if (stopwatch.isRunning) {
        var start = stopwatch.lastChangeTime.subtract(stopwatch.duration);
        var end = getMinDate(nextDayStart(start), now);
        while (end != now) {
          if (end.difference(start).inSeconds != 0) {
            historyToAdd.add(HistoryItemStorageModel(
                dayStart(start), end.difference(start), stopwatch.id));
          }
          start = end;
          end = getMinDate(nextDayStart(end), now);
        }
        await _stopwatchesRepo.updateStopwatch(
            StopwatchStorageModel(stopwatch.id, end.difference(start), true, now));
      } else {
        final day = DateTime(stopwatch.lastChangeTime.year,
            stopwatch.lastChangeTime.month, stopwatch.lastChangeTime.day);
        if (day != today) {
          if (stopwatch.duration.inSeconds != 0) {
            historyToAdd.add(HistoryItemStorageModel(
                stopwatch.lastChangeTime, stopwatch.duration, stopwatch.id));
          }
          await _stopwatchesRepo.updateStopwatch(StopwatchStorageModel(
              stopwatch.id,
              Duration.zero,
              false,
              stopwatch.lastChangeTime.add(stopwatch.duration)));
        }
      }
      await _historyRepo.addHistory(historyToAdd);
    }
  }
}
