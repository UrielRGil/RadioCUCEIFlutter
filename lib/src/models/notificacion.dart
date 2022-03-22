enum dias { L, M, I, J, V, S }

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


/* 
// To parse this JSON data, do
//
//     final subscripciones = subscripcionesFromMap(jsonString);

import 'dart:convert';

class Subscripciones {
    Subscripciones({
        this.status,
        this.data,
    });

    int status;
    List<Datum> data;

    factory Subscripciones.fromJson(String str) => Subscripciones.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Subscripciones.fromMap(Map<String, dynamic> json) => Subscripciones(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class Datum {
    Datum({
        this.codigoUsuario,
        this.dia,
        this.horario,
        this.nombrePrograma,
    });

    int codigoUsuario;
    String dia;
    String horario;
    String nombrePrograma;

    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
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
*/