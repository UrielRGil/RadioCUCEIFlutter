import 'package:http/http.dart' as http;
import 'dart:convert';

void completarFilas(List<dynamic> fila){
  int objetosNecesarios = 8 - fila.length;
  for(int i = 0; i < objetosNecesarios; i++){
    fila.add("-");
  }
}

Future<Horario> fetchHorario() async {
  final response = await http
      .get(Uri.parse('https://sheets.googleapis.com/v4/spreadsheets/17MPkO8PwnvsiAdL-U8n56oM-xhPjFPTvPt3xvQO-Keg/values/Sin_Formato!A2:H?key=AIzaSyDDvNYqFdVMbqU6F-HmXXJ1jGCCmLcOS68'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Horario.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('No se puede conseguir datos');
  }
}

class Horario {
  final List<dynamic> filas;

  const Horario({
    required this.filas
  });

  factory Horario.fromJson(Map<String, dynamic> json) {
    return Horario(
      filas: json['values']
    );
  }
}

Map<String, dynamic> generarDisponibilidad(List<dynamic> horario){
  final Map<int, String> dias = {
    1: 'L',
    2: 'M',
    3: 'I',
    4: 'J',
    5: 'V',
    6: 'S',
    7: 'D'
  };
  
  final Map<String, dynamic> disponibilidad = {};
  horario.forEach((fila){
    for(int i = 1; i < 8; i++){
      if(!disponibilidad.containsKey(fila[i])){
        disponibilidad[fila[i]] = {};
      }
      if(!disponibilidad[fila[i]].containsKey(dias[i])){
          disponibilidad[fila[i]][dias[i]] = [];
        }
      disponibilidad[fila[i]][dias[i]].add(fila[0]);
    }
  }
                 );
  return disponibilidad;
}