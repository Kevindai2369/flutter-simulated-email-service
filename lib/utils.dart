import 'package:intl/intl.dart';

class Utils {
  static String formatTimestamp(DateTime timestamp) {
    return DateFormat('yyyy-MM-dd hh:mm a').format(timestamp);
  }

  static String capitalize(String text) {
    return text.isNotEmpty
        ? '${text[0].toUpperCase()}${text.substring(1)}'
        : text;
  }
}
