import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'package:radiocucei/src/pages/inicio.dart';
import 'package:radiocucei/src/pages/tabla.dart';
import 'package:radiocucei/src/pages/redes.dart';
import 'package:radiocucei/src/pages/notifi.dart';
import 'package:radiocucei/src/services/audio_player_handler.dart';
import 'package:radiocucei/src/services/notificaciones_service.dart';

class HomePage extends StatefulWidget {
  final AudioPlayerHandler audioHandler;

  const HomePage({Key? key, required this.audioHandler}) : super(key: key);

  @override
  createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  @override
  Widget build(context) {
    final programService = Provider.of<NotificationsService>(context);
    programService.obtenerNotificaciones();
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: Scaffold(
        body: _Tabs(
          audioHandler: widget.audioHandler,
        ),
        bottomNavigationBar: const _Navegacion(),
      ),
    );
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.audiotrack_outlined),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Tabla',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.alternate_email_outlined),
          label: 'Redes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.view_list_rounded),
          label: 'Subscripciones',
        ),
      ],
      backgroundColor: Colors.white,
      selectedItemColor: Colors.purple.shade800,
      unselectedItemColor: Colors.pink.shade600,
      selectedFontSize: 20,
      unselectedFontSize: 15,
      iconSize: 30,
      currentIndex: navegacionModel.paginaActual,
      onTap: (index) => navegacionModel.paginaActual = index,
    );
  }
}

class _Tabs extends StatelessWidget {
  final AudioPlayerHandler audioHandler;
  const _Tabs({
    Key? key,
    required this.audioHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navegacionModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        InicioPage(audioHandler: audioHandler),
        TablaPage(),
        RedesPage(),
        Notifi(),
      ],
    );
  }
}

class _NavegacionModel extends ChangeNotifier {
  int _paginaActual = 0;
  final PageController _pageController = PageController();

  int get paginaActual => _paginaActual;

  set paginaActual(int index) {
    _paginaActual = index;

    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);

    notifyListeners();
  }

  PageController get pageController => _pageController;
}
