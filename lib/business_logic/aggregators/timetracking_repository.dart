
import '../../helpers/date_helpers.dart';
import '../boundary_crossing_objects/database_model.dart';
import '../entities/tracking_data.dart';
class TimetrackingRepository {
  final StopwatchDBInterface _stopwatchesRepo;
  final HistoryDBInterface _historyRepo;
  bool _stopwatchesProcessed = false;

  TimetrackingRepository(this._stopwatchesRepo, this._historyRepo);

  bool get stopwatchesProcessed => _stopwatchesProcessed;

  _preprocessDatabases() async {
    var stopwatchesData = await _stopwatchesRepo.getStopwatches();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    for (final stopwatch in stopwatchesData) {
      if (stopwatch.isRunning) {
        var start = stopwatch.lastChangeTime.subtract(stopwatch.duration);
        var end = getMinDate(nextDayStart(start), now);
        while (end != now) {
          await _historyRepo.addHistory(HistoryDBModel(
              dayStart(start), end.difference(start), stopwatch.id));
          start = end;
          end = getMinDate(nextDayStart(end), now);
        }
        await _stopwatchesRepo.updateStopwatch(
            StopwatchDBModel(stopwatch.id, end.difference(start), true, now));
      } else {
        final day = DateTime(stopwatch.lastChangeTime.year,
            stopwatch.lastChangeTime.month, stopwatch.lastChangeTime.day);
        if (day != today) {
          await _historyRepo.addHistory(HistoryDBModel(
              stopwatch.lastChangeTime, stopwatch.duration, stopwatch.id));
          await _stopwatchesRepo.updateStopwatch(StopwatchDBModel(
              stopwatch.id,
              Duration.zero,
              false,
              stopwatch.lastChangeTime.add(stopwatch.duration)));
        }
      }
    }
    _stopwatchesProcessed = true;
  }

  Future<List<StopwatchDBModel>> getStopwatches() async {
    if (!stopwatchesProcessed) {
      await _preprocessDatabases();
    }
    return await _stopwatchesRepo.getStopwatches();
  }

  Future<List<HistoryDBModel>> getHistory() async {
    if (!stopwatchesProcessed) {
      await _preprocessDatabases();
    }
    return await _historyRepo.getHistory();
  }

  updateStopwatch(ActiveTrackingData stopwatchDBModel) async {
    return await _stopwatchesRepo
        .updateStopwatch(StopwatchDBModel.fromEntity(stopwatchDBModel));
  }
}
