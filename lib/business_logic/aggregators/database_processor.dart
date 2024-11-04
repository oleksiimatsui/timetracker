import '../../helpers/date_helpers.dart';
import '../boundary_crossing_objects/database_model.dart';
import '../entities/tracking_data.dart';

class DatabaseProcessor {
  final StopwatchDBInterface _stopwatchesRepo;
  final HistoryDBInterface _historyRepo;

  DatabaseProcessor(this._stopwatchesRepo, this._historyRepo);

  process() async {
    var stopwatchesData = await _stopwatchesRepo.getStopwatches();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    List<HistoryItemDBModel> historyToAdd = [];
    for (final stopwatch in stopwatchesData) {
      if (stopwatch.isRunning) {
        var start = stopwatch.lastChangeTime.subtract(stopwatch.duration);
        var end = getMinDate(nextDayStart(start), now);
        while (end != now) {
          if (end.difference(start).inSeconds != 0) {
            historyToAdd.add(HistoryItemDBModel(
                dayStart(start), end.difference(start), stopwatch.id));
          }
          start = end;
          end = getMinDate(nextDayStart(end), now);
        }
        await _stopwatchesRepo.updateStopwatch(
            StopwatchDBModel(stopwatch.id, end.difference(start), true, now));
      } else {
        final day = DateTime(stopwatch.lastChangeTime.year,
            stopwatch.lastChangeTime.month, stopwatch.lastChangeTime.day);
        if (day != today) {
          if (stopwatch.duration.inSeconds != 0) {
            historyToAdd.add(HistoryItemDBModel(
                stopwatch.lastChangeTime, stopwatch.duration, stopwatch.id));
          }
          await _stopwatchesRepo.updateStopwatch(StopwatchDBModel(
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
