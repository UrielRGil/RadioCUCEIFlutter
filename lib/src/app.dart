import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:radiocucei/src/pages/home.dart';
import 'package:radiocucei/src/services/notificaciones_service.dart';

class Myapp extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
      home: Center(
        //child: HomaPage(),
        child: ChangeNotifierProvider(
            create: (BuildContext context) => NotificationsService(),
            child: HomePage()),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
