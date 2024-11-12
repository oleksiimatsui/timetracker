import 'package:flutter_test/flutter_test.dart';
import 'package:timetracker/business_logic/boundary_services/store_provider.dart';
import 'package:timetracker/data_access/activities_datasource.dart';
import 'package:timetracker/data_access/history_datasource.dart';
import 'package:timetracker/data_access/stopwatches_datasource.dart';

import 'test_configs.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    String path = TESTING_DIR;
    var activitiesDB = ActivitiesDatasource(path);
    var stopwatchesDB = StopwatchesDatasource(path);
    var historyDB = HistoryDatasource(path);
    activitiesDB.clear();
    stopwatchesDB.clear();
    historyDB.clear();
    StoreProvider.createStores(stopwatchesDB, historyDB, activitiesDB);
    StoreProvider.load();
  });

  test('add activity', () async {
   await StoreProvider.activitiesState.addActivity("My activity");
   assert(StoreProvider.activitiesState.activities.firstOrNull!.name == "My activity");
  });
  test('delete activity', () async {
    await StoreProvider.activitiesState.deleteActivity(1);
    assert(StoreProvider.activitiesState.activities.isEmpty);
  });
  test('start and stop activity', () async {
    // add activity
    await StoreProvider.activitiesState.addActivity("name");
    await pumpEventQueue();
    //run activity for 1 second
    await StoreProvider.stopwatchesState.startActivity(1);
    await Future.delayed(const Duration(seconds: 1));
    var elapsedTime = StoreProvider.stopwatchesState.runningActivityDuration;
    assert(elapsedTime!.inSeconds == 1);
    //stop activity
    int runningActivityId = StoreProvider.stopwatchesState.currentId!;
    await StoreProvider.stopwatchesState.stopActivity();
    await Future.delayed(const Duration(seconds: 1));
    var elapsedTime2 = StoreProvider.activitiesState.getActivitySavedDuration(runningActivityId);
    //activity time haven't changed after it was stopped
    assert(elapsedTime2!.inSeconds == 1);
  });
}
