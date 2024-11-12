import 'package:flutter_test/flutter_test.dart';
import 'package:timetracker/business_logic/aggregators/datasource_processor.dart';
import 'package:timetracker/data_access/history_datasource.dart';
import 'package:timetracker/data_access/stopwatches_datasource.dart';
import 'package:timetracker/helpers/date_helpers.dart';
import 'package:timetracker/business_logic/boundary_crossing_objects/database_model.dart';
import 'test_configs.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late DatasourceProcessor solver;
  String path = TESTING_DIR;
  var stopwatchRepo = StopwatchesDatasource(path);
  var historyRepo = HistoryDatasource(path);
  solver = DatasourceProcessor(stopwatchRepo, historyRepo);

  test("next day start", () {
    final date1 = DateTime(
      2024,
      10,
      27,
    );
    final date = nextDayStart(date1);
    assert(date.day == 28);
  });

  test("stopwatches to history", () async {
    runningHistoryTest() async {
      await stopwatchRepo.clear();
      await historyRepo.clear();
      DateTime now = DateTime.now();

      //make a stopwatch that was saved as running 1 day ago with duration 2 hours
      const daysCount = 1;
      const duration = Duration(hours: 2);
      final stopWatchDate = now.subtract(const Duration(days: daysCount));
      await stopwatchRepo
          .updateStopwatch(StopwatchStorageModel(1, duration, true, stopWatchDate));

      await solver.process();

      //get stopwatch and history
      var stopwatch = (await stopwatchRepo.getStopwatches()).firstOrNull!;
      var history = (await historyRepo.getHistory());

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
    }
    //
    // stoppedHistoryTest() async {
    //   await stopwatchRepo.clear();
    //   await historyRepo.clear();
    //   DateTime now = DateTime.now();
    //   // stopwatch runned for 10 minutes 2 days ago and was stopped
    //   const daysCount = 31;
    //   final stopWatchDate = now.subtract(const Duration(days: daysCount));
    //   await stopwatchRepo.updateStopwatch(StopwatchDBModel(
    //       1, const Duration(minutes: 10), false, stopWatchDate));
    //   await solver.process();
    //   //today the stopwatchh should have 0 duration
    //   var stopwatch = (await stopwatchRepo.getStopwatches()).firstOrNull!;
    //   var history = (await historyRepo.getHistory());
    //   assert(stopwatch.isRunning == false);
    //   assert(stopwatch.duration.inMinutes == 0);
    //   assert(history.length == 1);
    //   assert(history.firstOrNull!.duration.inMinutes == 10);
    // }
    //
    // noHistoryTest() async {
    //   await stopwatchRepo.clear();
    //   await historyRepo.clear();
    //   DateTime now = DateTime.now();
    //   // add a stopwatch that had been running for 1 hour 1 hour ago
    //   await stopwatchRepo.updateStopwatch(StopwatchDBModel(
    //       1,
    //       const Duration(hours: 1),
    //       true,
    //       now.subtract(const Duration(hours: 1))));
    //   await solver.process();
    //   var stopwatch = (await stopwatchRepo.getStopwatches()).firstOrNull!;
    //   var history = (await historyRepo.getHistory());
    //   //stopwatch is not running, duration is 2 hours, no history added
    //   assert(stopwatch.isRunning == true);
    //   assert(stopwatch.duration.inHours == 2);
    //   assert(history.isEmpty);
    // }

    await runningHistoryTest();
    // await stoppedHistoryTest();
    // await noHistoryTest();
  });
}
