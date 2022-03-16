import 'package:flutter/material.dart';
import 'package:radiocucei/src/models/notificacion.dart';
import 'package:radiocucei/src/services/storage_service.dart';

//TODO: Preguntar

class NotificationsService extends ChangeNotifier {
  List<Programa> programas = [];

  void agregarProgramas(Programa programa) {
    programa.codigoUsuario = AppStorage.idPlayer;

    programas.add(programa);
  }

  void eliminarPrograma(Programa programa) {
    final index = programas.indexWhere((element) =>
        element.dia == programa.dia && element.horario == programa.horario);
    programas.removeAt(index);
  }

  void saveAll() {
    if (programas.isNotEmpty) {
      print("Guardando todo");
      programas.clear();
    }
  }

  //TODO: Implementar
  //Future<List<Programa>> obtenerNotificaciones() {}
}
