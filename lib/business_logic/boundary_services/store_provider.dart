import 'package:timetracker/business_logic/boundary_services/stopwatches_store.dart';
import '../aggregators/activities.dart';
import '../aggregators/history.dart';
import '../aggregators/mediator.dart';
import '../aggregators/stopwatches.dart';
import '../boundary_crossing_objects/database_model.dart';
import 'activities_store.dart';
import 'app_theme.dart';
import 'history_store.dart';


/// Manages stores' static instances and provides access to them
class StoresHub{
  static late ActivitiesStore activitiesStore;
  static late StopwatchesStore stopwatchesStore;
  static late HistoryStore historyStore;
  static late ThemeStore themeStore;
  static late ManagersMediator _m;

  /// initializes the stores and the stores' mediator
  static createStores(StopwatchDSInterface stopwatchesDB, HistoryDSInterface historyDB, ActivityDSInterface activitiesDB){
    _m = ManagersMediator(stopwatchesDB,historyDB,activitiesDB);
    activitiesStore = ActivitiesStore(_m.activitiesManager);
    stopwatchesStore = StopwatchesStore(_m.stopwatchesManager);
    historyStore = HistoryStore(_m.historyManager);
    themeStore = ThemeStore();
    activitiesStore.activitiesStream.listen((event) {
      stopwatchesStore.load(activitiesStore.activities);
    });
  }

  /// fetches all the activities, stopwatches and history initial info.
  static load() async{
    await _m.load();
  }
}