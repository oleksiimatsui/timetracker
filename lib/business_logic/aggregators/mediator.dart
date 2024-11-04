import 'package:timetracker/business_logic/aggregators/database_processor.dart';
import 'package:timetracker/business_logic/aggregators/stopwatches.dart';
import '../boundary_crossing_objects/database_model.dart';
import 'activities.dart';
import 'history.dart';

class ManagersMediator{
  late Stopwatches stopwatchesManager;
  late Activities activitiesManager;
  late History historyManager;
  late DatabaseProcessor _dbProcessor;

  ManagersMediator(StopwatchDBInterface stopwatchesDB, HistoryDBInterface historyDB, ActivityDBInterface activitiesDB){
    stopwatchesManager = Stopwatches(stopwatchesDB);
    activitiesManager = Activities(activitiesDB, stopwatchesDB);
    historyManager = History(historyDB);
    _dbProcessor = DatabaseProcessor(stopwatchesDB, historyDB);

    activitiesManager.activitiesStream.listen((event) {
      stopwatchesManager.updateActivities(activitiesManager.getActivities());
      historyManager.load(activitiesManager.getActivities());
    });
  }
  load() async{
    await _dbProcessor.process();
    activitiesManager.load();
  }
}