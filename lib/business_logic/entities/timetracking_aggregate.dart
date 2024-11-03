
import 'activity.dart';



class ActivitiesList{
  List<Activity> activities = [];
  addActivity(Activity activity){
    activities.add(activity);
  }
  deleteActivity(Activity activity){
    activities.remove(activity);
  }

}