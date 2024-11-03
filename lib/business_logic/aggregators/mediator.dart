import 'package:timetracker/business_logic/aggregators/stopwatches.dart';
import 'activities.dart';
import 'history.dart';

class ManagersMediator{
  Activities activitiesManager;
  Stopwatches stopwatchesManager;
  History historyManager;

  ManagersMediator(this.activitiesManager,this.historyManager,this.stopwatchesManager){
    activitiesManager.activitiesStream.listen((event) {
      stopwatchesManager.updateActivities(activitiesManager.getActivities());
      historyManager.load(activitiesManager.getActivities());
    });
  }
}