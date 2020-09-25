
import 'package:chat_app/DataLayer/Calculation/DateCalculator.dart';
import 'package:intl/intl.dart';

class MessageDateFormatter {

  final _dateCalculator = DateCalculator();
  final _todayDateFormatter = DateFormat('HH:mm');
  final _notTodayDateFormatter = DateFormat('d MMM HH:mm');

  String format(DateTime date) {
    if (_dateCalculator.isDateToday(date)) {
      return _todayDateFormatter.format(date);
    } else {
      return _notTodayDateFormatter.format(date);
    }
  }
}