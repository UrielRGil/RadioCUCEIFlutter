import 'dart:convert';

/*
class Programa {
  late String _codigoUsuario;
  late String _dia;
  late String _horario;
  late String _nombrePrograma;
  final Map<String, String> _dias = {
    '1': 'L',
    '2': 'M',
    '3': 'I',
    '4': 'J',
    '5': 'V',
    '6': 'S'
  };

  Programa(String dia, String horario, String nombrePrograma) {
    switch (int.parse(dia)) {
      case 1:
        _dia = 'L';
        break;
      case 2:
        _dia = 'M';
        break;
      case 3:
        _dia = 'I';
        break;
      case 4:
        _dia = 'J';
        break;
      case 5:
        _dia = 'V';
        break;
      case 6:
        _dia = 'S';
        break;
    }
    _horario = horario;
    _nombrePrograma = nombrePrograma;
  }

  set codigoUsuario(String codigo) {
    _codigoUsuario = codigo;
  }

  set dia(String dia) {
    _dia = dia;
  }

  String get dia => _dia;

  String get horario => _horario;
}
*/

// To parse this JSON data, do
//
//     final subscripciones = subscripcionesFromMap(jsonString);

class Subscripciones {
  Subscripciones({
    required this.data,
  });

  List<Programa> data;

  factory Subscripciones.fromJson(String str) =>
      Subscripciones.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Subscripciones.fromMap(Map<String, dynamic> json) => Subscripciones(
        data: List<Programa>.from(json["data"].map((x) => Programa.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Programa {
  Programa({
    required this.codigoUsuario,
    required this.dia,
    required this.horario,
    required this.nombrePrograma,
  });

  String codigoUsuario;
  String dia;
  String horario;
  String nombrePrograma;

  factory Programa.create(
      String codigoUsuario, String dia, String horario, String nombrePrograma) {
    switch (int.parse(dia)) {
      case 1:
        dia = 'L';
        break;
      case 2:
        dia = 'M';
        break;
      case 3:
        dia = 'I';
        break;
      case 4:
        dia = 'J';
        break;
      case 5:
        dia = 'V';
        break;
      case 6:
        dia = 'S';
        break;
    }
    horario += ':00';
    return Programa(
        codigoUsuario: codigoUsuario,
        dia: dia,
        horario: horario,
        nombrePrograma: nombrePrograma);
  }

  factory Programa.fromJson(String str) => Programa.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Programa.fromMap(Map<String, dynamic> json) => Programa(
        codigoUsuario: json["codigo_usuario"],
        dia: json["dia"],
        horario: json["horario"],
        nombrePrograma: json["nombre_programa"],
      );

  Map<String, dynamic> toMap() => {
        "codigo_usuario": codigoUsuario,
        "dia": dia,
        "horario": horario,
        "nombre_programa": nombrePrograma,
      };
}
