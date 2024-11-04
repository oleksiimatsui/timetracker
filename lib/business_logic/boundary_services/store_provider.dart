import 'package:timetracker/business_logic/boundary_services/stopwatches_store.dart';
import '../aggregators/activities.dart';
import '../aggregators/history.dart';
import '../aggregators/mediator.dart';
import '../aggregators/stopwatches.dart';
import '../boundary_crossing_objects/database_model.dart';
import 'activities_store.dart';
import 'app_theme.dart';
import 'history_store.dart';

class StoreProvider{
  static late ActivitiesStore activitiesState;
  static late StopwatchesStore stopwatchesState;
  static late HistoryStore historyState;
  static late ThemeStore themeState;
  static late ManagersMediator _m;

  static createStores(StopwatchDBInterface stopwatchesDB, HistoryDBInterface historyDB, ActivityDBInterface activitiesDB){
    _m = ManagersMediator(stopwatchesDB,historyDB,activitiesDB);
    activitiesState = ActivitiesStore(_m.activitiesManager);
    stopwatchesState = StopwatchesStore(_m.stopwatchesManager);
    historyState = HistoryStore(_m.historyManager);
    themeState = ThemeStore();
    activitiesState.activitiesStream.listen((event) {
      stopwatchesState.load(activitiesState.activities);
    });
  }

  static load() async{
    await _m.load();
  }
}