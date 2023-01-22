library utils;

import 'dart:math';
import 'package:intl/intl.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class DateUtilss {
  static final DateFormat _monthFormat = DateFormat('MMMM yyyy');
  static final DateFormat _dayFormat = DateFormat('dd');
  static final DateFormat _firstDayFormat = DateFormat('MMM dd');
  static final DateFormat _fullDayFormat = DateFormat('EEE MMM dd, yyyy');
  static final DateFormat _apiDayFormat = DateFormat('yyyy-MM-dd');

  static String formatMonth(DateTime d) => _monthFormat.format(d);

  static String formatDay(DateTime d) => _dayFormat.format(d);

  static String formatFirstDay(DateTime d) => _firstDayFormat.format(d);

  static String fullDayFormat(DateTime d) => _fullDayFormat.format(d);

  static String apiDayFormat(DateTime d) => _apiDayFormat.format(d);

  static const List<String> weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  static const List months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  /// The list of days in a given month
  static List<DateTime> daysInMonth(DateTime month) {
    var first = firstDayOfMonth(month);
    var daysBefore = first.weekday;
    var firstToDisplay = first.subtract(Duration(days: daysBefore));
    var last = DateUtilss.lastDayOfMonth(month);

    var daysAfter = 7 - last.weekday;

    // If the last day is sunday (7) the entire week must be rendered
    if (daysAfter == 0) {
      daysAfter = 7;
    }

    // var lastToDisplay = last.add(Duration(days: daysAfter));
    return daysRange(first, last).toList();
  }

  static Iterable<DateTime> daysRange(DateTime first, DateTime last) {
    var listOfDates = new List<DateTime>.generate(
        last.day, (i) => DateTime(first.year, first.month, i + 1));
    return listOfDates;
  }

  static bool isFirstDayOfMonth(DateTime day) {
    return isSameDay(firstDayOfMonth(day), day);
  }

  static bool isLastDayOfMonth(DateTime day) {
    return isSameDay(lastDayOfMonth(day), day);
  }

  static DateTime firstDayOfMonth(DateTime month) {
    return DateTime(month.year, month.month);
  }

  static DateTime firstDayOfWeek(DateTime day) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    day = DateTime.utc(day.year, day.month, day.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar works from Sunday - Monday
    var decreaseNum = day.weekday % 7;
    return day.subtract(Duration(days: decreaseNum));
  }

  static DateTime lastDayOfWeek(DateTime day) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    day = DateTime.utc(day.year, day.month, day.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar's Week starts on Sunday
    var increaseNum = day.weekday % 7;
    return day.add(Duration(days: 7 - increaseNum));
  }

  /// The last day of a given month
  static DateTime lastDayOfMonth(DateTime month) {
    var beginningNextMonth = (month.month < 12)
        ? DateTime(month.year, month.month + 1, 1)
        : DateTime(month.year + 1, 1, 1);
    return beginningNextMonth.subtract(Duration(days: 1));
  }

  /// Returns a [DateTime] for each day the given range.
  ///
  /// [start] inclusive
  /// [end] exclusive
  static Iterable<DateTime> daysInRange(DateTime start, DateTime end) sync* {
    var i = start;
    var offset = start.timeZoneOffset;
    while (i.day <= end.day) {
      yield i;
      i = i.add(Duration(days: 1));
      var timeZoneDiff = i.timeZoneOffset - offset;
      if (timeZoneDiff.inSeconds != 0) {
        offset = i.timeZoneOffset;
        i = i.subtract(Duration(seconds: timeZoneDiff.inSeconds));
      }
    }
  }

  /// Whether or not two times are on the same day.
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isSameWeek(DateTime a, DateTime b) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    a = DateTime.utc(a.year, a.month, a.day);
    b = DateTime.utc(b.year, b.month, b.day);

    var diff = a.toUtc().difference(b.toUtc()).inDays;
    if (diff.abs() >= 7) {
      return false;
    }

    var min = a.isBefore(b) ? a : b;
    var max = a.isBefore(b) ? b : a;
    var result = max.weekday % 7 - min.weekday % 7 >= 0;
    return result;
  }

  static DateTime previousMonth(DateTime m) {
    var year = m.year;
    var month = m.month;
    if (month == 1) {
      year--;
      month = 12;
    } else {
      month--;
    }
    return DateTime(year, month);
  }

  double multiLinearRegressionDub(int max, int min) {
    Random random = Random();

    double num = (min + random.nextDouble() * max) * random.nextDouble();
    // num /= 100;
    num = double.parse(customRound(num, 1));
    // if(num/100 > 0)return 0.6;
    return num / 100;
  }

  double multiLinearRegressionInt(int max, int min) {
    Random random = Random();
    double num = (min + random.nextInt(max - min)) * random.nextDouble();
    num = double.parse(customRound(num, 1));
    // if(num > 0)return 0.6;
    return num;
  }

  int healthScrorePredict(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  bool multiLinearRegressionBool() {
    Random random = Random();

    return random.nextBool();
  }

  String customRound(double val, int places) {
    num mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod).toStringAsFixed(places);
  }

  void orangeCondition() {}
  void greenCondition() {}
  void purpleCondition() {}

  static DateTime nextMonth(DateTime m) {
    var year = m.year;
    var month = m.month;

    if (month == 12) {
      year++;
      month = 1;
    } else {
      month++;
    }
    return DateTime(year, month);
  }

  static DateTime previousWeek(DateTime w) {
    return w.subtract(Duration(days: 7));
  }

  static DateTime nextWeek(DateTime w) {
    return w.add(Duration(days: 7));
  }
}

class Classifier {
  late Interpreter interpreter;
  final _modelFile = 'modelSavedModelV2.tflite';

  Classifier() {
    testModel();

    ///classify(dubOne, dubTwo, dubThree, dubFour);
  }

  void testModel() async {
    interpreter = await Interpreter.fromAsset(_modelFile);
    print('Interpreter loaded successfully');
  }

  double classify(dubOne, dubTwo, dubThree, dubFour) {
    var input = [
      [dubOne, dubTwo, dubThree, dubFour]
    ];

    // if output tensor shape [1,2] and type is float32
    var output = List.filled(1 * 1, 0).reshape([1, 1]);

    // inference
    interpreter.run(input, output);

    interpreter.close();

    return output[0][0];
  }
}
