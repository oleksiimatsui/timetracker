
import 'activity.dart';

abstract class TrackingData {
  TrackingData(this.activity);
  Activity? activity;
  Duration get duration;
}

class ActiveTrackingData extends TrackingData {
  ActiveTrackingData(
      this.isRunning, this.lastChangeTime, super.activity, this._duration);

  final Duration _duration;
  bool isRunning;
  DateTime lastChangeTime;
  final Stopwatch _stopwatch = Stopwatch();

  start() {
    _stopwatch.start();
    isRunning = true;
    lastChangeTime = DateTime.now();
  }

  stop() {
    _stopwatch.stop();
    isRunning = false;
    lastChangeTime = DateTime.now();
  }

  @override
  Duration get duration {
    return _duration + _stopwatch.elapsed;
  }
}

class PastTrackingData extends TrackingData {
  PastTrackingData(this._startTime, this._duration, activity) : super(activity);
  final Duration _duration;
  final DateTime _startTime;
  @override
  Duration get duration{
    return _duration;
  }
  DateTime get startTime{
    return _startTime;
  }
}
