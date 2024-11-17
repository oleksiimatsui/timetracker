import '../../helpers/stream_container.dart';
import '../boundary_crossing_objects/datasource_model.dart';
import '../entities/activity.dart';
import '../entities/tracking_data.dart';

class Activities {
  final ActivityDSInterface _activitiesDatabase;
  final StopwatchDSInterface _stopwatchesDatabase;

  Activities(this._activitiesDatabase, this._stopwatchesDatabase);

  List<Activity> _activities = [];
  final StreamContainer _activitiesUpdates = StreamContainer(sync: true);
  Stream get activitiesStream => _activitiesUpdates.stream;

  List<Activity> getActivities() => _activities;


  Duration? getActivitySavedDuration(int activity) {
    Activity? activity0 =
        _activities.where((element) => element.id == activity).firstOrNull;
    return activity0?.duration;
  }

  load() async {
    var activitiesData = await _activitiesDatabase.getActivities();
    final stopwatches = await _stopwatchesDatabase.getStopwatches();
    _activities = activitiesData.map<Activity>((ActivityStorageModel x) {
      final s = stopwatches.where((element) => element.id == x.id).firstOrNull;
      StopwatchData? data = s != null
          ? StopwatchData(
              isRunning: s.isRunning,
              duration: s.duration,
              lastChangeTime: s.lastChangeTime)
          : null;
      Activity res = Activity(x.id, x.name ?? '', x.plannedDuration, data);
      return res;
    }).toList();
    _activitiesUpdates.emit();
  }

  addActivity(String name) async {
    Activity activity = Activity(null, name, null, null);
    await _activitiesDatabase.addActivity(ActivityStorageModel.fromEntity(activity));
    await load();
  }

  deleteActivity(int id) async {
    final activity =
        _activities.where((element) => element.id == id).firstOrNull;
    if (activity == null) {
      throw ("No activity with such id");
    }
    await _activitiesDatabase.deleteActivity(id);
    final ActiveTrackingData? stopwatch = activity.activeTrackingData;
    if (stopwatch != null) {
      await _stopwatchesDatabase
          .updateStopwatch(StopwatchStorageModel.fromEntity(stopwatch));
    }
    await load();
  }

  editActivityName(int id, String value) async{
    final activity =
        _activities.where((element) => element.id == id).firstOrNull;
    if (activity == null) {
      throw ("No activity with such id");
    }
    activity.name = value;
    await _activitiesDatabase.updateActivity(ActivityStorageModel.fromEntity(activity));
    await load();
  }
}
