import 'dart:async';
import 'package:timetracker/business_logic/boundary_crossing_objects/database_model.dart';
import '../../helpers/stream_container.dart';
import '../entities/activity.dart';


class Stopwatches{
  Activity? _runningActivity;
  List<Activity> _activities = [];
  final StopwatchDSInterface _db;
  Stopwatches(this._db);
  final StreamContainer _runningActivityUpdates = StreamContainer();
  Stream get runningActivityStream => _runningActivityUpdates.stream;
  int? _lastId;

  Duration? getRunningActivityDuration(){
    return _runningActivity?.duration;
  }
  int? getRunningActivityId(){
    return _runningActivity?.id;
  }
  getStoppedActivityId() {
    return _lastId;
  }
  startActivity(int activityId) async {
    _runningActivity = _activities.where((x) => x.id == activityId).firstOrNull;
    _runningActivity!.start();
    await _db.updateStopwatch(StopwatchStorageModel.fromEntity(_runningActivity!.activeTrackingData!));
    _runningActivityUpdates.emit();
  }
  stopActivity() async {
    Activity activity = _runningActivity!;
    _lastId = activity.id;
    activity.stop();
    _runningActivity = null;
    await _db.updateStopwatch(StopwatchStorageModel.fromEntity(activity.activeTrackingData!));
    _runningActivityUpdates.emit();
  }
  updateActivities(List<Activity> activities) async {
    _activities = activities;
    final stopwatches = await _db.getStopwatches();
    final running = stopwatches.where((element) => element.isRunning == true).firstOrNull;
    if(running != null && _runningActivity == null){
      final activity = activities.where((element) => element.id == running.id).firstOrNull;
      startActivity(activity!.id!);
    }
  }


}