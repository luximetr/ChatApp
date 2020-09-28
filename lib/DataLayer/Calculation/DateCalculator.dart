
class DateCalculator {

  bool isDateToday(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateWithoutTime = DateTime(date.year, date.month, date.day);
    return dateWithoutTime == today;
  }

  bool isLessOrEqual(DateTime date1, DateTime date2) {
    return !(date1.compareTo(date2) >= 1);
  }
}