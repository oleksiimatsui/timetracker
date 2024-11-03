import 'dart:async';
import 'package:timetracker/business_logic/aggregators/timetracking_repository.dart';
import '../../helpers/store.dart';
import '../entities/activity.dart';


class Stopwatches{
  Activity? _runningActivity;
  List<Activity> _activities = [];
  final TimetrackingRepository _timetrackingRepository;
  Stopwatches(this._timetrackingRepository);
  final StreamContainer _runningActivityUpdates = StreamContainer();
  Stream get runningActivityStream => _runningActivityUpdates.stream;
  int? _lastId;

  Duration? getRunningActivityDuration(){
    return _runningActivity?.duration;
  }
  int? getRunningActivityId(){
    return _runningActivity?.id;
  }
  startActivity(int activityId) async {
    _runningActivity = _activities.where((x) => x.id == activityId).firstOrNull;
    _runningActivity!.start();
    await _timetrackingRepository.updateStopwatch(_runningActivity!.activeTrackingData!);
    _runningActivityUpdates.emit();
  }
  stopActivity() async {
    Activity activity = _runningActivity!;
    _lastId = activity.id;
    activity.stop();
    _runningActivity = null;
    await _timetrackingRepository.updateStopwatch(activity.activeTrackingData!);
    _runningActivityUpdates.emit();
  }
  updateActivities(List<Activity> activities) async {
    _activities = activities;
    final stopwatches = await _timetrackingRepository.getStopwatches();
    final running = stopwatches.where((element) => element.isRunning == true).firstOrNull;
    if(running != null){
      final activity = activities.where((element) => element.id == running.id).firstOrNull;
      startActivity(activity!.id!);
    }
  }

  getStoppedActivityId() {
    return _lastId;
  }
}