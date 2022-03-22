import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:radiocucei/src/app.dart';
import 'package:radiocucei/src/services/storage_service.dart';

//TODO: Revisar que hacer cuando un programa cambia de dia

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("51c63cff-c83b-405e-927b-a9ce3234ec65");
  // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
  await AppStorage.init();
  final resp = AppStorage.isPlayerIdSave();
  if (!resp) {
    final deviceState = OneSignal.shared.getDeviceState().then((state) {
      AppStorage.savePlayerId(state?.userId);
    });
  }

  runApp(Myapp());
}
