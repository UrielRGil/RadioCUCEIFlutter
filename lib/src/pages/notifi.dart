import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radiocucei/src/services/notificaciones_service.dart';
import 'package:radiocucei/src/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';

//TODO: Implementar estilo al IconButton
// TODO: Implementar estilo a las fuentes

class Notifi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificationsService = Provider.of<NotificationsService>(context);
    final programs = notificationsService.programas;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 16),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.purple, Colors.red])),
        child: FutureBuilder(
          future: notificationsService.obtenerNotificaciones(),
          initialData: const [],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                final programa = programs[index];
                return BounceInUp(
                  animate: true,
                  duration: const Duration(milliseconds: 800),
                  child: SubscriptionTile(
                      index: index,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('${programa.nombrePrograma} (${programa.dia})',
                                style: _customTextStyle()),
                            Expanded(child: Container()),
                            Text(
                              programa.horario,
                              style: _customTextStyle(),
                            ),
                          ],
                        ),
                      )),
                );
              },
              itemCount: programs.length,
            );
          },
        ),
      ),
    );
  }

  TextStyle _customTextStyle() =>
      const TextStyle(color: Colors.white, fontSize: 20);
}
