import 'package:flutter/material.dart';
import 'package:radiocucei/src/models/notificacion.dart';
import 'package:radiocucei/src/services/storage_service.dart';
import 'package:http/http.dart' as http;

//TODO: Preguntar sobre el diseño de la pagina
//datos

class NotificationsService extends ChangeNotifier {
  List<Programa> programas = [];
  List<Programa> nuevosProgramas = [];

  final String _baseUrl = '148.202.152.33';

  bool agregarProgramas(Programa programa) {
    final exist = programas.indexWhere((element) =>
        element.dia == programa.dia && element.horario == programa.horario);

    if (exist != -1) return false;

    nuevosProgramas.add(programa);

    return true;
  }

  bool eliminarPrograma(Programa programa) {
    final index = nuevosProgramas.indexWhere((element) =>
        element.dia == programa.dia && element.horario == programa.horario);
    try {
      nuevosProgramas.removeAt(index);
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  void saveAll() async {
    if (nuevosProgramas.isNotEmpty) {
      Subscripciones subs = Subscripciones(data: nuevosProgramas);

      final jsonMap = subs.toJson();

      final url = Uri.http(_baseUrl, '/RadioCucei/notificaciones.php');

      await http.post(url, body: {'datos': jsonMap});

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

  Future<bool> unSubscribe(int index) async {
    final program = programas[index];
    programas.removeAt(index);

    final url = Uri.http(_baseUrl, 'RadioCucei/elimina.php', {
      'id': program.codigoUsuario,
      'dia': program.dia,
      'hora': program.horario
    });

    final resp = await http.get(url);

    if (resp.body == 'ok') {
      notifyListeners();
      return true;
    }

    return false;
  }
}
