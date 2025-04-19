import 'package:intl/intl.dart';

import '../enums/date_enum.dart';

String formatDate({required inputDate, DateFormatType? formatType}) {
  DateTime dateTime = DateTime.parse(inputDate);

  String pattern;
  switch (formatType!) {
    case DateFormatType.short:
      pattern = 'MM/dd/yyyy';
      break;
    case DateFormatType.long:
      pattern = 'MMMM d, yyyy';
      break;
    case DateFormatType.withTime:
      pattern = 'MMMM d, yyyy hh:mm a';
      break;
    case DateFormatType.iso:
      pattern = 'yyyy-MM-ddTHH:mm:ssZ';
      break;
    case DateFormatType.timeOnly:
      pattern = 'hh:mm a';
      break;
    case DateFormatType.dayMonth:
      pattern = 'dd MMM';
      break;
    case DateFormatType.dayMonthYear:
      pattern = 'dd MMM yyyy';
      break;
    case DateFormatType.monthDay:
      pattern = 'MMM dd';
      break;
    case DateFormatType.monthDayYear:
      pattern = 'MMM dd, yyyy';
      break;
    case DateFormatType.weekday:
      pattern = 'EEEE';
      break;
    case DateFormatType.weekdayLong:
      pattern = 'EEEE, MMMM d, yyyy';
      break;
    case DateFormatType.weekdayShort:
      pattern = 'EEE, MMM d';
      break;
    case DateFormatType.yearMonth:
      pattern = 'MMMM yyyy';
      break;
    case DateFormatType.yearOnly:
      pattern = 'yyyy';
      break;
    case DateFormatType.timeWithSeconds:
      pattern = 'hh:mm:ss a';
      break;
    case DateFormatType.isoDateOnly:
      pattern = 'yyyy-MM-dd';
      break;
    case DateFormatType.fullDateTime:
      pattern = 'EEEE, MMMM d, yyyy hh:mm:ss a';
      break;
    default:
      pattern = 'MMMM d, yyyy';
  }

  return DateFormat(pattern, 'fr_FR').format(dateTime);
}
