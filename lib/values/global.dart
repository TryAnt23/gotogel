import 'dart:async';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class Global {
  static Timer getLocationTimer;
  static bool isLoading = false;

  static String latestUriGlobal = '';
  static RemoteConfig remoteConfig;

  static Future<RemoteConfig> getRemoteConfig() async {
    if (Global.remoteConfig == null) {
      Global.remoteConfig = await RemoteConfig.instance;
      await Global.remoteConfig.fetch(expiration: const Duration(minutes: 1));
      await Global.remoteConfig.activateFetched();
    }
    return Global.remoteConfig;
  }
}
