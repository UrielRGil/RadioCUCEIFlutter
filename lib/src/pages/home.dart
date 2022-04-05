import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:radiocucei/src/pages/inicio.dart';
import 'package:radiocucei/src/pages/tabla.dart';
import 'package:radiocucei/src/pages/redes.dart';
import 'package:radiocucei/src/pages/notifi.dart';
import 'package:radiocucei/src/services/notificaciones_service.dart';

class HomePage extends StatefulWidget {
  @override
  createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(context) {
    final programService = Provider.of<NotificationsService>(context);
    programService.obtenerNotificaciones();
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: Scaffold(
        body: _Tabs(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
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
          icon: Icon(Icons.notifications_active_outlined),
          label: 'Notificaciones',
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
  const _Tabs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navegacionModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        InicioPage(),
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
