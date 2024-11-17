import 'package:timetracker/business_logic/entities/tracking_data.dart';

import '../../values/dimensions.dart';



/// stopwatch data that is used only in the [Activity] constructor
class StopwatchData{
  bool isRunning;
  DateTime lastChangeTime;
  Duration duration;
  StopwatchData({required this.isRunning, required this.duration, required this.lastChangeTime});
}


/// activity entity
///
///
class Activity{
  Activity(this.id, this.name, Duration? plannedDuration, StopwatchData? stopwatch):
        plannedDuration = plannedDuration ?? const Duration(hours: DEFAULT_PLANNED_HOURS){
    if(stopwatch != null){
      activeTrackingData = ActiveTrackingData(stopwatch.isRunning, stopwatch.lastChangeTime!, this, stopwatch.duration);
    }
  }

  /// id of activity.
  /// it can be null if activity is not saved yet
  int? id;
  /// name of activity that the user will see
  String name;
  /// planned daily duration of the activity
  ///
  /// by default it is equal to 4 hours
  Duration plannedDuration;
  ActiveTrackingData? activeTrackingData;

  /// current elapsed time of activity's stopwatch
  Duration get duration => activeTrackingData?.duration ?? const Duration(seconds: 0);
  /// whether activity is running or paused
  bool get isRunning => activeTrackingData?.isRunning ?? false;
  /// the last time when the activity's stopwatch state was toggled
  DateTime? get lastChangeTime => activeTrackingData?.lastChangeTime;

  _initTrackingData(){
    activeTrackingData = ActiveTrackingData(false, DateTime.now(), this, const Duration(seconds: 0));
  }

  /// starts the activity's stopwatch
  start(){
    if(activeTrackingData == null) _initTrackingData();
    activeTrackingData!.start();
  }
  /// stops the activity's stopwatch
  stop(){
    if(activeTrackingData == null) _initTrackingData();
    activeTrackingData!.stop();
  }
}