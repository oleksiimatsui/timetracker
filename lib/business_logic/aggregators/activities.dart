import 'package:timetracker/business_logic/aggregators/timetracking_repository.dart';
import '../../helpers/store.dart';
import '../boundary_crossing_objects/database_model.dart';
import '../boundary_crossing_objects/response_model.dart';
import '../entities/activity.dart';
import '../entities/tracking_data.dart';

class Activities {
  final ActivityDBInterface _activitiesDatabase;
  final TimetrackingRepository _ttr;
  Activities(this._activitiesDatabase, this._ttr);
  List<Activity> _activities = [];
  final StreamContainer _activitiesUpdates = StreamContainer(sync: true);
  Stream get activitiesStream => _activitiesUpdates.stream;

  List<Activity> getActivities() => _activities;

  List<ActivityData> getActivitiesData() {
    return _activities
        .map((x) => ActivityData(x.id ?? 0, x.name, x.plannedDuration))
        .toList();
  }

  Duration? getActivitySavedDuration(int activity) {
      Activity? activity0 =
          _activities.where((element) => element.id == activity).firstOrNull;
      return activity0?.duration;
  }

  load() async {
    var activitiesData = await _activitiesDatabase.getActivities();
    final stopwatches = await _ttr.getStopwatches();
    _activities = activitiesData.map<Activity>((ActivityDBModel x) {
      final s = stopwatches.where((element) => element.id == x.id).firstOrNull;
      StopwatchData? data = s != null ? StopwatchData(isRunning: s.isRunning, duration: s.duration, lastChangeTime: s.lastChangeTime) : null;
      Activity res = Activity(x.id, x.name ?? '', x.plannedDuration, data);
      return res;
    }).toList();
    _activitiesUpdates.emit();
  }

  addActivity(String name) async {
    Activity activity = Activity(null, name, null, null);
    await _activitiesDatabase
        .addActivity(ActivityDBModel.fromEntity(activity));
  }

  deleteActivity(int id) async {
    final activity =
        _activities.where((element) => element.id == id).firstOrNull;
    if (activity == null) {
      throw ("No activity with such id");
    }
    await _activitiesDatabase.deleteActivity(id);
    final ActiveTrackingData? stopwatch = activity.activeTrackingData;
    if(stopwatch != null)
    await _ttr.updateStopwatch(stopwatch);
  }
}
