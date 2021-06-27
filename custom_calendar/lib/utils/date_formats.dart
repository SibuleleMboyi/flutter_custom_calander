import 'package:intl/intl.dart';

class DataFormats {
  static String getDay({required DateTime date}) {
    final day = DateFormat.d().format(date);
    return day;
  }
}
