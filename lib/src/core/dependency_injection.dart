import 'dart:io';

import 'package:lesa/src/src.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class DependencyInjection {
  static Future<void> inject() async {
    late final Directory documentsDirectory;
    late final Directory supportDirectory;

    late final PackageInfo packageInfo;

    await Future.wait<void>([
      (() async => documentsDirectory = await getApplicationDocumentsDirectory())(),
      (() async => supportDirectory = await getApplicationSupportDirectory())(),
      (() async => packageInfo = await PackageInfo.fromPlatform())(),
    ]);

    sl.safeRegisterSingleton<AppDocumentsDirectory>(AppDocumentsDirectory(directory: documentsDirectory));

    sl.safeRegisterSingleton<AppSupportDirectory>(AppSupportDirectory(directory: supportDirectory));

    sl.safeRegisterSingleton<PackageInfo>(packageInfo);
  }
}
