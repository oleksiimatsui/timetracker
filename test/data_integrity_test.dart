import 'package:flutter_test/flutter_test.dart';
import 'package:timetracker/business_logic/aggregators/timetracking_repository.dart';
import 'package:timetracker/data_access/history_database.dart';
import 'package:timetracker/data_access/stopwatches_database.dart';
import 'package:timetracker/helpers/date_helpers.dart';
import 'package:timetracker/business_logic/boundary_crossing_objects/database_model.dart';
import 'test_configs.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late TimetrackingRepository solver;
  String path = TESTING_DIR;
  var stopwatchRepo = StopwatchesDatabase(path);
  var historyRepo = HistoryDatabase(path);

  setUpAll(() async {
    solver = TimetrackingRepository(stopwatchRepo, historyRepo);
  });
  test('running stopwatch history creation', () async {
    await stopwatchRepo.clear();
    await historyRepo.clear();
    DateTime now = DateTime.now();

    //make a stopwatch that was saved as running 1 day ago with duration 2 hours
    const daysCount = 12;
    const duration = Duration(hours: 2);
    final stopWatchDate = now.subtract(const Duration(days: daysCount));
    await stopwatchRepo.updateStopwatch(
        StopwatchDBModel(1, duration, true, stopWatchDate));

    //get stopwatch and history
    var stopwatch = (await solver.getStopwatches()).firstOrNull!;
    var history = (await solver.getHistory());

    //stopwatch should be running
    //duration should be (now - dayStart(now))
    //there should be one record in history
    //duration of history record is nextDay(date)-date + duration
    assert(stopwatch.isRunning == true);
    assert(stopwatch.duration.inMinutes ==
        now.difference(dayStart(now)).inMinutes);
    assert(history.length == daysCount);
    assert(history.firstOrNull!.duration ==
        nextDayStart(stopWatchDate).add(duration).difference(stopWatchDate));
  });
  test('stopped stopwatch history creation', () async {
    await stopwatchRepo.clear();
    await historyRepo.clear();
    DateTime now = DateTime.now();
    const daysCount = 31;
    final stopWatchDate = now.subtract(const Duration(days: daysCount));
    await stopwatchRepo.updateStopwatch(StopwatchDBModel(
        1, const Duration(minutes: 10), false, stopWatchDate));
    var stopwatch = (await solver.getStopwatches()).firstOrNull!;
    var history = (await solver.getHistory());
    assert(stopwatch.isRunning == false);
    assert(stopwatch.duration.inMinutes == 0);
    assert(history.length == 1);
    assert(history.firstOrNull!.duration.inMinutes == 10);
  });
  test('running stopwatch app closing', () async {
    await stopwatchRepo.clear();
    await historyRepo.clear();
    DateTime now = DateTime.now();
    // add a stopwatch that had been running for 1 hour 1 hour ago
    await stopwatchRepo.updateStopwatch(
        StopwatchDBModel(1, const Duration(hours: 1), true, now.subtract(const Duration(hours: 1))));
    var stopwatch = (await solver.getStopwatches()).firstOrNull!;
    var history = (await solver.getHistory());
    assert(stopwatch.isRunning == true);
    assert(stopwatch.duration.inHours == 2);
    assert(history.isEmpty);
  });
}
