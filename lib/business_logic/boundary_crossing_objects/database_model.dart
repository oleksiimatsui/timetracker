
import '../entities/activity.dart';
import '../entities/tracking_data.dart';

abstract class ActivityDBInterface {
  Future<List<ActivityDBModel>> getActivities();
  Future addActivity(ActivityDBModel model);
  Future deleteActivity(int id);
  Future updateActivity(ActivityDBModel model);
}

abstract class HistoryDBInterface {
  Future<List<HistoryItemDBModel>> getHistory();
  Future addHistory(List<HistoryItemDBModel> model);
}

abstract class StopwatchDBInterface {
  Future<List<StopwatchDBModel>> getStopwatches();
  Future updateStopwatch(StopwatchDBModel model);
}


class ActivityDBModel {
  ActivityDBModel(this.id, this.name, this.plannedDuration);

  String? name;
  Duration? plannedDuration;
  int? id;
  StopwatchDBModel? stopwatch;

  factory ActivityDBModel.fromEntity(Activity activity) {
    return ActivityDBModel(
      activity.id,
      activity.name,
      activity.plannedDuration,
    );
  }
}

class StopwatchDBModel {
  StopwatchDBModel(
      this.id, this.duration, this.isRunning, this.lastChangeTime);

  int id;
  Duration duration;
  bool isRunning;
  DateTime lastChangeTime;

  factory StopwatchDBModel.fromEntity(
      ActiveTrackingData entity) {
    return StopwatchDBModel(
        entity.activity!.id!,
        entity.duration, entity.isRunning, entity.lastChangeTime);
  }
}

class HistoryItemDBModel {
  HistoryItemDBModel(this.date, this.duration, this.activityId);
  DateTime date;
  Duration duration;
  int activityId;
}