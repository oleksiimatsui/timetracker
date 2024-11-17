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
    StoresHub.createStores(stopwatchesDB, historyDB, activitiesDB);
    StoresHub.load();
  });

  test('add activity', () async {
   await StoresHub.activitiesStore.addActivity("My activity");
   assert(StoresHub.activitiesStore.activities.firstOrNull!.name == "My activity");
  });
  test('delete activity', () async {
    await StoresHub.activitiesStore.deleteActivity(1);
    assert(StoresHub.activitiesStore.activities.isEmpty);
  });
  test('start and stop activity', () async {
    // add activity
    await StoresHub.activitiesStore.addActivity("name");
    await pumpEventQueue();
    //run activity for 1 second
    await StoresHub.stopwatchesStore.startActivity(1);
    await Future.delayed(const Duration(seconds: 1));
    var elapsedTime = StoresHub.stopwatchesStore.runningActivityDuration;
    assert(elapsedTime!.inSeconds == 1);
    //stop activity
    int runningActivityId = StoresHub.stopwatchesStore.currentId!;
    await StoresHub.stopwatchesStore.stopActivity();
    await Future.delayed(const Duration(seconds: 1));
    var elapsedTime2 = StoresHub.activitiesStore.getActivitySavedDuration(runningActivityId);
    //activity time haven't changed after it was stopped
    assert(elapsedTime2!.inSeconds == 1);
  });
}
