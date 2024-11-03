
class ActivityData{
  ActivityData(this.id, this.name, this.plannedDuration);
  String name;
  Duration plannedDuration;
  int id;
}

class HistoryItemData{
  int? activityId;
  Duration duration;
  DateTime day;
  HistoryItemData(this.activityId, this.duration, this.day);
}
