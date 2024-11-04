import 'package:flutter_test/flutter_test.dart';
import 'package:timetracker/business_logic/boundary_crossing_objects/database_model.dart';
import 'package:timetracker/data_access/activities_database.dart';
import 'package:timetracker/data_access/history_database.dart';
import 'package:timetracker/data_access/stopwatches_database.dart';
import 'test_configs.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ActivitiesDatabase repo;
  late StopwatchesDatabase stopwatchRepo;
  late HistoryDatabase historyRepository;

  setUpAll(() async {
    repo = ActivitiesDatabase(TESTING_DIR);
    stopwatchRepo = StopwatchesDatabase(TESTING_DIR);
    historyRepository = HistoryDatabase(TESTING_DIR);
    await repo.clear();
    await repo.addActivity(
        ActivityDBModel(null, "Activity", const Duration(seconds: 1)));
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
    await stopwatchRepo.updateStopwatch(StopwatchDBModel(
        1, Duration.zero, false, DateTime.now()));
    var watches = await stopwatchRepo.getStopwatches();
    assert(watches.isNotEmpty);
  });
  test('save history', () async {
    await historyRepository.clear();
    await historyRepository.addHistory([HistoryItemDBModel(DateTime.now().subtract(Duration(days: 4)), Duration(hours: 4), 1)]);
    var hist = await historyRepository.getHistory();
    assert(hist.length == 1);
  });
}
