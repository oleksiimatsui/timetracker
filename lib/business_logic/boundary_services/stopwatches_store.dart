import 'dart:async';
import '../../helpers/store.dart';
import '../aggregators/stopwatches.dart';
import '../boundary_crossing_objects/response_model.dart';


class StopwatchesStore {
  final Stopwatches _manager;

  StopwatchesStore(this._manager) {
    _manager.runningActivityStream.listen((event) {
      if (_manager.getStoppedActivityId() != null) {
        _stopUpdates(_manager.getStoppedActivityId());
      }
      if (_manager.getRunningActivityId() != null) {
        _startUpdates(_manager.getRunningActivityId());
      }

    });
  }

  final StreamMap _stopwatchUpdates = StreamMap();

  Stream getStopwatchStream(int id) {
    return _stopwatchUpdates.get(id);
  }

  Timer? timer;

  int? get currentId {
    return _manager.getRunningActivityId();
  }

  load(List<ActivityData> activities) async {
    _stopwatchUpdates.init(activities.map((x) => x.id!).toList());
  }

  startActivity(id) async {
    if (currentId != null) {
      await stopActivity();
    }
    await _manager.startActivity(id);
  }

  stopActivity() async {
    await _manager.stopActivity();
  }

  _startUpdates(id) {
    _stopwatchUpdates.emit(id!);
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      _stopwatchUpdates.emit(id!);
    });
  }

  _stopUpdates(id) {
    timer!.cancel();
    if (id != null) {
      _stopwatchUpdates.emit(id);
    }
  }

  bool activityIsRunning(int id) {
    return currentId == id;
  }

  Duration? get runningActivityDuration {
    return _manager.getRunningActivityDuration();
  }
}
