import 'package:flutter_test/flutter_test.dart';
import 'package:timetracker/business_logic/boundary_crossing_objects/datasource_model.dart';
import 'package:timetracker/data_access/activities_datasource.dart';
import 'package:timetracker/data_access/history_datasource.dart';
import 'package:timetracker/data_access/stopwatches_datasource.dart';
import 'test_configs.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ActivitiesDatasource repo;
  late StopwatchesDatasource stopwatchRepo;
  late HistoryDatasource historyRepository;

  setUpAll(() async {
    repo = ActivitiesDatasource(TESTING_DIR);
    stopwatchRepo = StopwatchesDatasource(TESTING_DIR);
    historyRepository = HistoryDatasource(TESTING_DIR);
    await repo.clear();
    await repo.addActivity(
        ActivityStorageModel(null, "Activity", const Duration(seconds: 1)));
  });
  test('add activity', () async {
    await repo.addActivity(
        ActivityStorageModel(null, "Activity", const Duration(seconds: 1)));
    await repo.addActivity(
        ActivityStorageModel(null, "Activity", const Duration(seconds: 1)));
    var activities = await repo.getActivities();
    assert(activities[0].id == 2);
  });
  test('delete activity', () async {
    var activities = await repo.getActivities();
    assert(activities.length == 1);
    await repo.deleteActivity(1);
    activities = await repo.getActivities();
    assert(activities.isEmpty);
  });
  test('save stopwatch data', () async {
    await stopwatchRepo.clear();
    await stopwatchRepo.updateStopwatch(StopwatchStorageModel(
        1, Duration.zero, false, DateTime.now()));
    var watches = await stopwatchRepo.getStopwatches();
    assert(watches.isNotEmpty);
  });
  test('save history', () async {
    await historyRepository.clear();
    await historyRepository.addHistory([HistoryItemStorageModel(DateTime.now().subtract(Duration(days: 4)), Duration(hours: 4), 1)]);
    var hist = await historyRepository.getHistory();
    assert(hist.length == 1);
  });
}
