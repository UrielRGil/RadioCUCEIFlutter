import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import 'package:radiocucei/src/pages/inicio.dart';
import 'package:radiocucei/src/pages/tabla.dart';
import 'package:radiocucei/src/pages/redes.dart';
import 'package:radiocucei/src/pages/notifi.dart';
import 'package:radiocucei/src/services/notificaciones_service.dart';

class HomerPage extends StatefulWidget {
  @override
  createState() {
    return _HomerPageState();
  }
}

class _HomerPageState extends State<HomerPage>
    with AutomaticKeepAliveClientMixin {
  final List<Widget> _paginas = [
    InicioPage(),
    TablaPage(),
    RedesPage(),
    SingleChildScrollViewWidget(),
  ];

  int _paginaactual = 0;

  _onTapped(int index) {
    setState(() {
      _paginaactual = index;
    });
  }

  @override
  Widget build(context) {
    super.build(context);
    final programService = Provider.of<NotificationsService>(context);
    return Scaffold(
        body: IndexedStack(
          index: _paginaactual,
          children: <Widget>[..._paginas],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            if (_paginaactual == 1 && index != _paginaactual) {
              programService.saveAll();
            }
            setState(() {
              _paginaactual = index;
            });
          },
          currentIndex: _paginaactual,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.purple.shade800,
          unselectedItemColor: Colors.pink.shade600,
          selectedFontSize: 20,
          unselectedFontSize: 15,
          iconSize: 30,
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
              icon: Icon(Icons.settings),
              label: 'Notifi',
            ),
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
