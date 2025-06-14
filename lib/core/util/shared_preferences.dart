import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/profile/data/response/profile_response.dart';
import '../strings/enum_manager.dart';

class AppSharedPreference {
  static const _token = '1';
  static const _phoneNumber = '2';
  static const _fireToken = '3';
  static const _lang = '4';
  static const _screenType = '5';
  static const _user = '6';
  static const _notifications = '7';
  static const _notificationCount = '8';
  static const _testIosFromServer = '9';
  static const _resendTime = '10';
  static const _isLoginToChatApp = '11';

  static SharedPreferences? _prefs;

  static Future<void> setResendDateTime(int s) async {
    final d = DateTime.now().add(Duration(seconds: s));
    await _prefs?.setString(_resendTime, d.toIso8601String());
  }

  static DateTime get getResendDateTime =>
      DateTime.tryParse(_prefs?.getString(_resendTime) ?? '') ?? DateTime.now();

  static changeTestIosFromServer(bool state) {
    _prefs?.setBool(_testIosFromServer, state);
  }

  static reload() async => await _prefs?.reload();

  static bool get isInitial => _prefs != null;

  static init(SharedPreferences preferences) => _prefs = preferences;

  static cashToken(String? token) {
    if (token == null) return;
    _prefs?.setString(_token, token);
  }

  static String get getToken => _prefs?.getString(_token) ?? '';

  static cashNotificationState(bool n) {
    _prefs?.setBool(_notifications, n);
  }

  static bool get getNotificationState => _prefs?.getBool(_notifications) ?? true;

  static cashLoginToChatApp(bool b) {
    _prefs?.setBool(_isLoginToChatApp, b);
  }

  static bool get getIsLoginToChatApp => _prefs?.getBool(_isLoginToChatApp) ?? false;

  static Future<void> cashUser(UserModel user) async {
    final json = user.toJson();

    await _prefs?.setString(_user, jsonEncode(json));
  }

  static UserModel get getUser =>
      UserModel.fromJson(jsonDecode(_prefs?.getString(_user) ?? '{}'));

  static void cashFireToken(String token) {
    _prefs?.setString(_fireToken, token);
  }

  static String get getFireToken => _prefs?.getString(_fireToken) ?? '';

  static cashPhone(String? phone) async {
    if (phone == null) return;
    await _prefs?.setString(_phoneNumber, phone);
  }

  static String get getPhone {
    return _prefs?.getString(_phoneNumber) ?? '';
  }

  static Future<void> removePhone() async {
    await _prefs?.remove(_phoneNumber);
  }

  static cashStartPage(StartPage type) async {
    await _prefs?.setInt(_screenType, type.index);
  }

  static StartPage get getStartPage => StartPage.values[_prefs?.getInt(_screenType) ?? 0];

  static Future<void> clear() async => await _prefs?.clear();

  static Future<void> logout() async => await _prefs?.clear();

  static Future<void> cashLocal(String langCode) async {
    await _prefs?.setString(_lang, langCode);
  }

  static String get getLocal => _prefs?.getString(_lang) ?? 'ar';

  static void addNotificationCount() {
    var count = getNotificationCount() + 1;
    _prefs?.setInt(_notificationCount, count);
  }

  static int getNotificationCount() {
    return _prefs?.getInt(_notificationCount) ?? 0;
  }

  static void clearNotificationCount() {
    _prefs?.setInt(_notificationCount, 0);
  }
}
