import 'package:timetracker/business_logic/entities/tracking_data.dart';

class StopwatchData{
  bool isRunning;
  DateTime lastChangeTime;
  Duration duration;
  StopwatchData({required this.isRunning, required this.duration, required this.lastChangeTime});
}

class Activity{
  Activity(this.id, this.name, Duration? plannedDuration, StopwatchData? stopwatch):
        plannedDuration = plannedDuration ?? const Duration(hours: 4){
    if(stopwatch != null){
      activeTrackingData = ActiveTrackingData(stopwatch.isRunning, stopwatch.lastChangeTime!, this, stopwatch.duration);
    }
  }

  int? id;
  String name;
  Duration plannedDuration;
  ActiveTrackingData? activeTrackingData;

  Duration get duration => activeTrackingData?.duration ?? const Duration(seconds: 0);
  bool get isRunning => activeTrackingData?.isRunning ?? false;
  DateTime? get lastChangeTime => activeTrackingData?.lastChangeTime;

  _initTrackingData(){
    activeTrackingData = ActiveTrackingData(false, DateTime.now(), this, const Duration(seconds: 0));
  }

  start(){
    if(activeTrackingData == null) _initTrackingData();
    activeTrackingData!.start();
  }
  stop(){
    if(activeTrackingData == null) _initTrackingData();
    activeTrackingData!.stop();
  }
}