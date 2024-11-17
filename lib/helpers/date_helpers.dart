



/// returns the minimum date among [date1] and [date2]
DateTime getMinDate(DateTime date1, DateTime date2) {
  return date1.isBefore(date2) ? date1 : date2;
}

/// returns the start of the day of the [dateTime] (in local timezone)
///
/// For example,
/// dayStart(DateTime(2024, 11, 17, 15, 30))
/// will return 2024-11-17 00:00:00.000
DateTime dayStart(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

/// returns the start of the next day of the [dateTime] (in local timezone)
///
/// For example,
/// dayStart(DateTime(2024, 11, 17, 15, 30))
/// will return 2024-11-18 00:00:00.000
DateTime nextDayStart(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day+1);
}
