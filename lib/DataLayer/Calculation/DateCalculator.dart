
class DateCalculator {

  bool isDateToday(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateWithoutTime = DateTime(date.year, date.month, date.day);
    return dateWithoutTime == today;
  }

  bool isGreaterThan(DateTime date1, DateTime date2) {
    final normalisedDate1 = _roundToMilliseconds(date1);
    final normalizedDate2 = _roundToMilliseconds(date2);
    return normalisedDate1.compareTo(normalizedDate2) >= 1;
  }

  bool isLessOrEqual(DateTime date1, DateTime date2) {
    return !isGreaterThan(date1, date2);
  }

  DateTime _roundToMilliseconds(DateTime date) {
    final milliseconds = date.microsecond > 500 ? date.millisecond + 1: date.millisecond;
    return DateTime(date.year, date.month, date.day, date.hour, date.minute, date.second, milliseconds);
  }
}