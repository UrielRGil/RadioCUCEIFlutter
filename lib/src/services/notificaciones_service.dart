import 'package:flutter/material.dart';
import 'package:radiocucei/src/models/notificacion.dart';
import 'package:radiocucei/src/services/storage_service.dart';
import 'package:http/http.dart' as http;

//TODO: Preguntar sobre el diseño de la pagina
//datos

class NotificationsService extends ChangeNotifier {
  List<Programa> programas = [];
  final String _baseUrl = '148.202.152.33';

  void agregarProgramas(Programa programa) {
    programas.add(programa);
  }

  void eliminarPrograma(Programa programa) {
    final index = programas.indexWhere((element) =>
        element.dia == programa.dia && element.horario == programa.horario);
    programas.removeAt(index);
  }

  void saveAll() async {
    if (programas.isNotEmpty) {
      Subscripciones subs = Subscripciones(data: programas);

      final jsonMap = subs.toJson();

      final url = Uri.http(_baseUrl, '/notificaciones.php', {'datos': jsonMap});

      final resp = await http.post(url);

      //final resp = await http.post(url, body: json);

      programas.clear();
      notifyListeners();
    }
  }

  //TODO: Implementar

  Future<List<Programa>> obtenerNotificaciones() async {
    final url = Uri.http(
        _baseUrl, '/RadioCucei/favoritos.php', {'codigo': AppStorage.idPlayer});

    final response = await http.get(url);
    final json = addKey(response.body);

    programas = Subscripciones.fromJson(json).data;
    notifyListeners();
    return programas;
  }

  String addKey(String json) {
    Map<String, dynamic> jsonChido = {'"data"': json};

    return jsonChido.toString();
  }
}
