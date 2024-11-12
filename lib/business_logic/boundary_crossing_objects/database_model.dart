
import '../entities/activity.dart';
import '../entities/tracking_data.dart';

abstract class ActivityDSInterface {
  Future<List<ActivityStorageModel>> getActivities();
  Future addActivity(ActivityStorageModel model);
  Future deleteActivity(int id);
  Future updateActivity(ActivityStorageModel model);
}

abstract class HistoryDSInterface {
  Future<List<HistoryItemStorageModel>> getHistory();
  Future addHistory(List<HistoryItemStorageModel> model);
}

abstract class StopwatchDSInterface {
  Future<List<StopwatchStorageModel>> getStopwatches();
  Future updateStopwatch(StopwatchStorageModel model);
}


class ActivityStorageModel {
  ActivityStorageModel(this.id, this.name, this.plannedDuration);

  String? name;
  Duration? plannedDuration;
  int? id;
  StopwatchStorageModel? stopwatch;

  factory ActivityStorageModel.fromEntity(Activity activity) {
    return ActivityStorageModel(
      activity.id,
      activity.name,
      activity.plannedDuration,
    );
  }
}

class StopwatchStorageModel {
  StopwatchStorageModel(
      this.id, this.duration, this.isRunning, this.lastChangeTime);

  int id;
  Duration duration;
  bool isRunning;
  DateTime lastChangeTime;

  factory StopwatchStorageModel.fromEntity(
      ActiveTrackingData entity) {
    return StopwatchStorageModel(
        entity.activity!.id!,
        entity.duration, entity.isRunning, entity.lastChangeTime);
  }
}

class HistoryItemStorageModel {
  HistoryItemStorageModel(this.date, this.duration, this.activityId);
  DateTime date;
  Duration duration;
  int activityId;
}