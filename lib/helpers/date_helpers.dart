DateTime getMinDate(DateTime date1, DateTime date2) {
  return date1.isBefore(date2) ? date1 : date2;
}

DateTime dayStart(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

DateTime nextDayStart(DateTime dateTime) {
  return dayStart(dateTime.add(Duration(days: 1)));
}
