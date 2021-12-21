/*
 * Created on Sat Feb 06 2021
 * Created by - 3: Mayur Ranjan
 *
 * Copyright (c) 2021 Hobbies-Lobbies Pvt Ltd.
 */

import 'package:intl/intl.dart';

enum DateType { isAfter, isBefore }

class DateUtils {
  static DateTime getAfterOrBeforeDate({
    DateType? type,
    DateTime? date,
    int? years,
    int? months,
    int? days,
    int? hours,
    int? minutes,
    int? seconds,
    int? milliseconds,
    int? microseconds,
  }) {
    date ??= DateTime.now();
    days ??= 0;
    hours ??= 0;
    minutes ??= 0;
    seconds ??= 0;
    milliseconds ??= 0;
    microseconds ??= 0;

    if (years != null) {
      days += years * 365;
    }
    if (months != null) {
      days += months * 30;
    }

    switch (type) {
      case DateType.isBefore:
        date = date.subtract(Duration(
            days: days,
            hours: hours,
            minutes: minutes,
            seconds: seconds,
            milliseconds: milliseconds,
            microseconds: microseconds));
        break;
      case DateType.isAfter:
      default:
        date = date.add(Duration(
            days: days,
            hours: hours,
            minutes: minutes,
            seconds: seconds,
            milliseconds: milliseconds,
            microseconds: microseconds));
        break;
    }
    return date;
  }

  static String getDateTimeAsString(
      {required DateTime dateTime, required String format}) {
    return DateFormat(format).format(dateTime);
  }

  static String getApiDateAsString({required DateTime dateTime}) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String getCalendarDateAsString({required DateTime dateTime}) {
    return DateFormat('dd-MMM-yyyy').format(dateTime);
  }

  static String getApiDateTimeAsString({required DateTime dateTime}) {
    return DateFormat('yyyy-MM-dd HH:MM:ss').format(dateTime);
  }

  static String getClockDateTimeAsString({required DateTime dateTime}) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  static DateTime getStringAsDateTime(
      {required String dateTime, required String format}) {
    return DateFormat(format).parse(dateTime);
  }

  static DateTime getCalendarStringAsDateTime({required String dateTime}) {
    return DateFormat('dd-MMM-yyyy').parse(dateTime);
  }

  static DateTime getApiStringFormat2AsDateTime({required String dateTime}) {
    return DateFormat('dd-MM-yyyy').parse(dateTime);
  }

  static DateTime getApiStringAsDateTime({required String dateTime}) {
    return DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(dateTime);
  }
}
