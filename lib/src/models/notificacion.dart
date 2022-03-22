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
