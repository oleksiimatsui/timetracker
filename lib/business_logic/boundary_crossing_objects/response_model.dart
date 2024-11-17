/// activity data for usage in UI
class ActivityData{
  ActivityData(this.id, this.name, this.plannedDuration);
  String name;
  Duration plannedDuration;
  int id;
}

/// history item data for usage in UI
class HistoryItemData{
  int? activityId;
  Duration duration;
  DateTime day;
  HistoryItemData(this.activityId, this.duration, this.day);
}
