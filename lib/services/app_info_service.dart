import 'package:package_info_plus/package_info_plus.dart';

import '../core/api_manager/api_service.dart';

PackageInfo? _appData;
bool lookMode = false;

class AppInfoService {
  static Future<void> initial() async {
    try {
      _appData = await PackageInfo.fromPlatform();
    } catch (e) {
      loggerObject.e(e);
    }
  }

  static PackageInfo get appInfo => _appData!;

  static String get fullVersionName => 'النسخة:( ${appInfo.version} ) | البنية:( ${appInfo.buildNumber} )';
}
