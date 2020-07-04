import 'package:jpush_flutter/jpush_flutter.dart';

class LibSetUp {

  static Future init() async {
    JPush manger = JPush();
    manger.getRegistrationID().then((rid) {});
      manger.setup(
      appKey: 'a3e9fd8f7c067a7bbdddb478',
      channel: 'guanjia_channel',
      production: true,
      debug: false,
    );
    manger.applyPushAuthority(
        NotificationSettingsIOS(sound: true, alert: true, badge: true));
  }

}
