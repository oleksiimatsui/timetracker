
import 'activity.dart';

/// activity's data with duration
abstract class TrackingData {
  TrackingData(this.activity);
  Activity? activity;
  Duration get duration;
}


/// stopwatch entity
class ActiveTrackingData extends TrackingData {
  ActiveTrackingData(
      this.isRunning, this.lastChangeTime, super.activity, this._duration);

  final Duration _duration;
  /// whether the stopwatch is running or paused
  bool isRunning;
  /// time of last start/stop operation execution
  DateTime lastChangeTime;


  final Stopwatch _stopwatch = Stopwatch();

  /// starts the stopwatch
  start() {
    _stopwatch.start();
    isRunning = true;
    lastChangeTime = DateTime.now();
  }

  /// stops the stopwatch
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

/// contains the duration of time binded to a date
class PastTrackingData extends TrackingData {
  PastTrackingData(this._date, this._duration, activity) : super(activity);
  final Duration _duration;
  final DateTime _date;
  @override
  Duration get duration{
    return _duration;
  }
  DateTime get date{
    return _date;
  }
}
