import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:easy_localization/easy_localization.dart';

const String dateFormatter = 'MMMM dd, y';

extension DateHelper on DateTime {

  String formatDate() {
    final formatter = DateFormat(dateFormatter,myLocale.toString());
    return formatter.format(this);
  }
  bool isSameDate(DateTime other) {
    return this.year == other.year && this.month == other.month && this.day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}