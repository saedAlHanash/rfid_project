import 'dart:convert';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rfid_project/core/api_manager/api_service.dart';

import '../../generated/l10n.dart';
import '../error/error_manager.dart';
import '../strings/app_color_manager.dart';
import '../strings/enum_manager.dart';
import '../util/pair_class.dart';
import '../util/snack_bar_message.dart';
import '../widgets/spinner_widget.dart';

extension SplitByLength on String {
  List<String> splitByLength1(int length, {bool ignoreEmpty = false}) {
    List<String> pieces = [];

    for (int i = 0; i < this.length; i += length) {
      int offset = i + length;
      String piece = substring(i, offset >= this.length ? this.length : offset);

      if (ignoreEmpty) {
        piece = piece.replaceAll(RegExp(r'\s+'), '');
      }

      pieces.add(piece);
    }
    return pieces;
  }

  String get logLongMessage {
    var r = [];
    var res = '';
    if (length > 800) {
      r = splitByLength1(800);
      for (var e in r) {
        res += '$e\n';
      }
    } else {
      res = this;
    }
    return res;
  }

  bool get canSendToSearch {
    if (isEmpty) false;

    return split(' ').last.length > 2;
  }

  int get numberOnly {
    final regex = RegExp(r'\d+');

    final numbers = regex.allMatches(this).map((match) => match.group(0)).join();

    try {
      return int.parse(numbers);
    } on Exception {
      return 0;
    }
  }

  bool get isZero => (num.tryParse(this) ?? 0) == 0;

  String? checkPhoneNumber(BuildContext context, String phone) {
    if (phone.startsWith('00964') && phone.length > 11) return phone;
    if (phone.length < 10) {
      NoteMessage.showSnakeBar(context: context, message: S.of(context).wrongPhone);
      return null;
    } else if (phone.startsWith("0") && phone.length < 11) {
      NoteMessage.showSnakeBar(context: context, message: S.of(context).wrongPhone);
      return null;
    }

    if (phone.length > 10 && phone.startsWith("0")) phone = phone.substring(1);

    phone = '00964$phone';

    return phone;
  }

  String get removeSpace => replaceAll(' ', '');

  String get removeDuplicates {
    List<String> words = split(' ');
    Set<String> uniqueWords = Set<String>.from(words);
    List<String> uniqueList = uniqueWords.toList();
    String output = uniqueList.join(' ');
    return output;
  }

  num get tryParseOrZero => num.tryParse(this) ?? 0;

  num tryParseOr(num n) => num.tryParse(this) ?? n;

  int get tryParseOrZeroInt => int.tryParse(this) ?? 0;

  num? get tryParseOrNull => num.tryParse(this);

  int? get tryParseOrNullInt => int.tryParse(this);

  String maxLength(int l) {
    if (length > l) return substring(0, l);
    return this;
  }

  String get getKey {
    // var bytes = utf8.encode(this);
    // var digest = md5.convert(bytes);
    // var digest1 = sha1.convert(bytes);
    var digest2 = hashCode.toString();

    // loggerObject.w('${digest} \n$digest1\n$digest2 ');
    return digest2.maxLength(10);
  }

  VideoPlatform get detectVideoPlatform {
    String youtubePattern = r'^[A-Za-z0-9_-]{11}$';
    String dailymotionPattern = r'^[A-Za-z0-9]{6,20}$';

    if (contains("http")) {
      return VideoPlatform.youtube;
    }
    if (int.tryParse(this) != null) {
      return VideoPlatform.vimeo;
    }

    if (RegExp(youtubePattern).hasMatch(this)) {
      return VideoPlatform.youtube;
    }
    if (RegExp(dailymotionPattern).hasMatch(this)) {
      return VideoPlatform.dailymotion;
    }

    return VideoPlatform.dailymotion;
  }

  double get estimateTextWidth {
    return length * 16 * 0.3;
  }
}

extension StringHelper on String? {
  String get fixUrl {
    if (this == null) return '';
    if ((this ?? '').startsWith('http')) return this ?? '';
    final String link = "http://e-learning.testbandtech.com/storage/images/$this";
    return link;
  }

  String? get fixPhone {
    if (this == null) return null;
    if ((this ?? '').startsWith('+964')) return this ?? '';
    final p = this!
        .replaceAll('٠', '0')
        .replaceAll('١', '1')
        .replaceAll('٢', '2')
        .replaceAll('٣', '3')
        .replaceAll('٤', '4')
        .replaceAll('٥', '5')
        .replaceAll('٦', '6')
        .replaceAll('٧', '7')
        .replaceAll('٨', '8')
        .replaceAll('٩', '9');

    return '+964$p'.replaceAll('+9640', '+964');
  }

  String? get getVideoId => this?.split('/').lastOrNull;
}

final oCcy = NumberFormat("#,###", "en_US");

extension MaxInt on num {
  int get max => 2147483647;

  String get formatPrice => oCcy.format(this);

  Widget get counterWidget => Container(
    height: 40.0.r,
    width: 40.0.r,
    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColorManager.cardColor),
    alignment: Alignment.center,
    child: DrawableText(
      text: this == 0 ? '' : toInt().toString().padLeft(2, '0'),
      color: AppColorManager.mainColor,
    ),
  );
}

extension MaxIntNulable on num? {
  bool get isBlankNumber {
    if (this == null) return true;
    return (this!) <= 0;
  }
}

extension HelperJson on Map<String, dynamic> {
  num getAsNum(String key) {
    if (this[key] == null) return -1;
    return num.tryParse((this[key]).toString()) ?? -1;
  }
}

extension ListEnumHelper on List {
  List<SpinnerItem> getSpinnerItems({int? selectedId, Widget? icon}) {
    return List<SpinnerItem>.from(
      map(
        (e) => SpinnerItem(id: e.index, isSelected: e.index == selectedId, name: e.name, icon: icon, item: e),
      ),
    );
  }
}

extension ResponseHelper on http.Response {
  Map<String, dynamic> get jsonBody {
    try {
      return jsonDecode(body)['data'] ?? {};
    } catch (e) {
      return jsonDecode('{}');
    }
  }

  Map<String, dynamic> get jsonBodyPure {
    try {
      return jsonDecode(body);
    } catch (e) {
      return jsonDecode('{}');
    }
  }

  DateTime get serverTime {
    final dateString = (headers['date'] ?? '');

    // Define the format that matches the date string
    final format = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'", 'en_US');

    // Parse the string to DateTime
    final parsedDate = format.parseUtc(dateString);

    return DateTime.parse(parsedDate.toIso8601String().replaceAll(RegExp(r'[Zz]'), ''));
  }

  // Pair<T?, String?> getPairError<T>() {
  //   return Pair(null, ErrorManager.getApiError(this));
  // }
  get getPairError {
    return Pair(null, ErrorManager.getApiError(this));
  }
}

extension FormatDuration on Duration {
  String get format {
    var includeDays = false;

    final h = inHours.remainder(24);
    final m = inMinutes.remainder(60);
    final s = inSeconds.remainder(60);

    final buffer = StringBuffer();

    // if (includeDays && d > 0) buffer.write('${d.toString().padLeft(2, '0')}:');
    if (includeDays || h > 0) buffer.write('${h.toString().padLeft(2, '0')}:');

    buffer
      ..write('${m.toString().padLeft(2, '0')}:')
      ..write(s.toString().padLeft(2, '0'));

    return buffer.toString();
  }

  String get formatString {
    final months = inDays.abs() ~/ 30;
    final days = inDays.abs() % 360;
    final hours = inHours.abs() % 24;
    final minutes = inMinutes.abs() % 60;
    final seconds = inSeconds.abs() % 60;
    final result = FormatDateTime(
      months: months,
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );

    final formattedDuration = StringBuffer();

    var c = 0;
    if (result.months > 0) {
      c++;
      formattedDuration.write('${S().and} ${result.months} ${S().month}');
    }
    if (result.days > 0 && c < 2) {
      c++;
      formattedDuration.write('${S().and} ${result.days} ${S().day}  ');
    }
    if (result.hours > 0 && c < 2) {
      c++;
      formattedDuration.write('${S().and} ${result.hours} ${S().hour}  ');
    }
    if (result.minutes > 0 && c < 2) {
      c++;
      formattedDuration.write('${S().and} ${result.minutes} ${S().minute}  ');
    }
    if (result.seconds > 0 && c < 2) {
      c++;
      formattedDuration.write('${S().and} ${result.seconds} ${S().second} ');
    }

    return formattedDuration.toString().trim().replaceFirst(S().and, '');
  }
}

extension ApiStatusCode on int {
  bool get success => (this >= 200 && this <= 210);

  //
  // int get countDiv2 {
  //   final dr = this / 2; //double result
  //   final ir = this ~/ 2; //int result
  //   return (ir < dr) ? ir + 1 : ir;
  // }
  int get countDiv2 => (this ~/ 2 < this / 2) ? this ~/ 2 + 1 : this ~/ 2;
}

extension TextEditingControllerHelper on TextEditingController {
  void clear() {
    if (text.isNotEmpty) text = '';
  }
}

extension DateUtcHelper on DateTime {
  int get hashDate => (day * 61) + (month * 83) + (year * 23);

  DateTime get getUtc => DateTime.utc(year, month, day);

  String get formatDate => DateFormat('yyyy/MM/dd', 'en').format(this);

  String get formatDateAther => DateFormat('yyyy/MM/dd HH:MM').format(this);

  String get formatTime => DateFormat('h:mm a').format(this);

  String get formatDateTime => '$formatTime $formatDate';

  String get formatDateTimeVertical => '$formatDate\n$formatTime';

  DateTime addFromNow({int? year, int? month, int? day, int? hour, int? minute, int? second}) {
    return DateTime(
      this.year + (year ?? 0),
      this.month + (month ?? 0),
      this.day + (day ?? 0),
      this.hour + (hour ?? 0),
      this.minute + (minute ?? 0),
      this.second + (second ?? 0),
    );
  }

  DateTime initialFromDateTime({required DateTime date, required TimeOfDay time}) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  FormatDateTime getFormat({DateTime? serverDate}) {
    final difference = this.difference(serverDate ?? DateTime.now());

    final months = difference.inDays.abs() ~/ 30;
    final days = difference.inDays.abs() % 360;
    final hours = difference.inHours.abs() % 24;
    final minutes = difference.inMinutes.abs() % 60;
    final seconds = difference.inSeconds.abs() % 60;
    return FormatDateTime(months: months, days: days, hours: hours, minutes: minutes, seconds: seconds);
  }

  String formatDuration({DateTime? serverDate}) {
    if (isAfter(serverDate ?? APIService().serverTime)) return '';
    final result = getFormat(serverDate: serverDate);

    final formattedDuration = StringBuffer();

    var c = 0;
    if (result.months > 0) {
      c++;
      formattedDuration.write('${S().and} ${result.months} ${S().month}');
    }
    if (result.days > 0 && c < 2) {
      c++;
      formattedDuration.write('${S().and} ${result.days} ${S().day}  ');
    }
    if (result.hours > 0 && c < 2) {
      c++;
      formattedDuration.write('${S().and} ${result.hours} ${S().hour}  ');
    }
    if (result.minutes > 0 && c < 2) {
      c++;
      formattedDuration.write('${S().and} ${result.minutes} ${S().minute}  ');
    }
    if (result.seconds > 0 && c < 2) {
      c++;
      formattedDuration.write('${S().and} ${result.seconds} ${S().second} ');
    }

    return formattedDuration.toString().trim().replaceFirst(S().and, '');
  }

  String get timeLeft {
    if (isBefore(APIService().serverTime)) return '';
    final result = getFormat(serverDate: APIService().serverTime);

    final formattedDuration = StringBuffer();

    var c = 0;
    if (result.months > 0) {
      c++;
      formattedDuration.write('${S().and} ${result.months} ${S().month}');
    }
    if (result.days > 0 && c < 2) {
      c++;
      formattedDuration.write('${S().and} ${result.days} ${S().day}  ');
    }
    if (result.hours > 0 && c < 2) {
      c++;
      formattedDuration.write('${S().and} ${result.hours} ${S().hour}  ');
    }
    if (result.minutes > 0 && c < 2) {
      c++;
      formattedDuration.write('${S().and} ${result.minutes} ${S().minute}  ');
    }
    if (result.seconds > 0 && c < 2) {
      c++;
      formattedDuration.write('${S().and} ${result.seconds} ${S().second} ');
    }

    return formattedDuration.toString().trim().replaceFirst(S().and, '');
  }

  int get getWeekNumber {
    final DateTime firstJan = DateTime(year, 1, 1);
    // final int daysInYear = DateTime(year + 1, 1, 1).difference(firstJan).inDays;
    final int weekNumber = (difference(firstJan).inDays ~/ 7) + 1;
    // If the date is after the first Monday of the year, then it is in the current week.
    if (weekday >= 1) {
      return weekNumber;
    }
    // Otherwise, it is in the previous week.
    return weekNumber - 1;
  }

  DateTime get fixTimeZone => add(DateTime.now().timeZoneOffset);
}

extension FirstItem<E> on Iterable<E> {
  E? get firstItem => isEmpty ? null : first;
}

extension GetDateTimesBetween on DateTime {
  List<DateTime> getDateTimesBetween({required DateTime end, required Duration period}) {
    var dateTimes = <DateTime>[];
    var current = add(period);
    while (current.isBefore(end)) {
      if (dateTimes.length > 24) {
        break;
      }
      dateTimes.add(current);
      current = current.add(period);
    }
    return dateTimes;
  }
}

class FormatDateTime {
  final int months;
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  const FormatDateTime({
    required this.months,
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  @override
  String toString() {
    return '$months\n'
        '$days\n'
        '$hours\n'
        '$minutes\n'
        '$seconds\n';
  }
}
