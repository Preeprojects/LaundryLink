import 'package:intl/intl.dart';

class DateHelper {
  static String formatDate(DateTime date) {
    return DateFormat('EEE, MMM d, yyyy').format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat('h:mm a').format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('EEE, MMM d, yyyy h:mm a').format(date);
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static List<DateTime> getTimeSlots(DateTime date) {
    List<DateTime> slots = [];
    for (int hour = 8; hour < 20; hour++) {
      slots.add(DateTime(date.year, date.month, date.day, hour, 0));
      slots.add(DateTime(date.year, date.month, date.day, hour, 30));
    }
    return slots;
  }
}
