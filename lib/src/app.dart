import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:radiocucei/src/pages/home.dart';
import 'package:radiocucei/src/services/audio_player_handler.dart';
import 'package:radiocucei/src/services/notificaciones_service.dart';

class Myapp extends StatelessWidget {
  final AudioPlayerHandler audioPlayerHandler;

  const Myapp({Key? key, required this.audioPlayerHandler}) : super(key: key);

  @override
  Widget build(context) {
    return MaterialApp(
      home: Center(
        //child: HomaPage(),
        child: ChangeNotifierProvider(
            create: (BuildContext context) => NotificationsService(),
            child: HomePage(
              audioHandler: audioPlayerHandler,
            )),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
