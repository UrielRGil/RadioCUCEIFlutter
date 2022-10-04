import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:radiocucei/src/app.dart';
import 'package:radiocucei/src/services/audio_player_handler.dart';
import 'package:radiocucei/src/services/storage_service.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("51c63cff-c83b-405e-927b-a9ce3234ec65");
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
  await AppStorage.init();
  final resp = AppStorage.isPlayerIdSave();
  if (!resp) {
    OneSignal.shared.getDeviceState().then((state) {
      AppStorage.savePlayerId(state?.userId);
    });
  }

  final audioHandler = await AudioService.init(
      builder: () => AudioPlayerHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
        androidNotificationChannelName: 'Audio playback',
        androidNotificationOngoing: true,
      ));

  runApp(Myapp(audioPlayerHandler: audioHandler));
}
