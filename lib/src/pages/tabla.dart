import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radiocucei/src/componentes/utils.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:collection/collection.dart';
import 'package:radiocucei/src/models/notificacion.dart';
import 'package:radiocucei/src/services/notificaciones_service.dart';
import 'package:radiocucei/src/services/storage_service.dart';

class TablaPage extends StatefulWidget {
  @override
  createState() {
    return _TablaPageState();
  }
}

class _TablaPageState extends State<TablaPage> {
  final List<MultiSelectItem<String?>> itemsHorario = [];
  late Future<Horario> futureHorario;
  List<dynamic> h = [];
  bool valor = false;
  String elemento = "";
  late NotificationsService notificationService;

  @override
  void initState() {
    futureHorario = fetchHorario();
    super.initState();
  }

  @override
  void dispose() {
    notificationService.saveAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    notificationService = Provider.of<NotificationsService>(context);

    return MaterialApp(
        home: Scaffold(
      body: Column(
        children: [
          //contenedor superios
          Flexible(
            flex: 4,
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [Colors.purple, Colors.red])),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.07,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.07,
                    ),
                    child: const Text(
                      "Programacion radio CUCEI",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Fredes'),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.10,
                    child: const Text(
                      "Seleccione el programa que quiere que se le notifique",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'FDredes'),
                    ),
                  )
                ],
              ),
            ),
          ),

          //contenedor medio
          Flexible(
            flex: 9,
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  child: FutureBuilder<Horario>(
                    future: futureHorario,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        h = snapshot.data!.filas;
                        h.forEach((fila) {
                          completarFilas(fila);
                        });
                        final Map<String, dynamic> disponibilidad =
                            generarDisponibilidad(h);
                        //Iterar sobre programa
                        disponibilidad.forEach((k, v) {
                          //Iterar sobre dias de ese programa
                          v.forEach((k1, v1) {
                            //Iterar sobre horas de ese programa
                            v1.forEach((elemento) {
                              itemsHorario.add(MultiSelectItem<String>(
                                  "$k el $k1 a las $elemento",
                                  "$k el $k1 a las $elemento"));
                            });
                          });
                        });
                        return generarFormulario(h);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ),
            ),
          ),

          //contenedor inferior
          Flexible(
            flex: 1,
            child: Container(
              //color: Colors.amber,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [Colors.purple, Colors.red])),
            ),
          ),
        ],
      ),
    ));
  }

  //https://www.woolha.com/tutorials/flutter-using-datatable-widget-examples
  DataTable generarHorario(List<dynamic> resultado) {
    return DataTable(
      columns: [
        DataColumn(
          label: filasprogramas('LUNES'),
        ),
        DataColumn(
          label: filasprogramas('MARTES'),
        ),
        DataColumn(
          label: filasprogramas('MIERCOLES'),
        ),
        DataColumn(
          label: filasprogramas('JUEVES'),
        ),
        DataColumn(
          label: filasprogramas('VIERNES'),
        ),
        DataColumn(
          label: filasprogramas('SABADO'),
        ),
        DataColumn(
          label: filasprogramas('DOMINGO'),
        ),
      ],
      rows: [
        for (List<dynamic> fila in resultado)
          DataRow(
              // color: MaterialStateProperty.all(Colors.white.withOpacity(0.75)),
              cells: _makeCells(fila))
      ],
    );
  }

  List<DataCell> _makeCells(List<dynamic> fila) {
    List<DataCell> cells = [];
    fila.forEachIndexed((index, element) {
      if (!element.contains(':')) {
        cells.add(DataCell(_DataRow(
          elemento: element,
          hora: fila[0],
          index: index.toString(),
        )));
      }
    });

    return cells;
  }

  Expanded filasprogramas(String dia) {
    var _estilosuperiorletras = const TextStyle(
        color: Colors.purple, fontSize: 25, fontWeight: FontWeight.bold);
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Colors.pink, width: 1, style: BorderStyle.solid),
          borderRadius: const BorderRadius.all(Radius.circular(1)),
        ),
        child: Text(
          dia,
          style: _estilosuperiorletras,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Column generarFormulario(List<dynamic> resultado) {
    return Column(
      children: <Widget>[
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: generarHorario(resultado),
            ),
          ),
        ),
      ],
    );
  }
}

class _DataRow extends StatefulWidget {
  final String elemento;
  final String hora;
  final String index;

  _DataRow(
      {Key? key,
      required this.elemento,
      required this.hora,
      required this.index})
      : super(key: key);

  @override
  __DataRowState createState() => __DataRowState(elemento, hora, index);
}

class __DataRowState extends State<_DataRow> {
  bool _isSelected = false;
  final String elemento;
  final String hora;
  final String index;
  bool resp = false;
  String mensaje = '';
  __DataRowState(this.elemento, this.hora, this.index);
  @override
  Widget build(BuildContext context) {
    final notificationsService = Provider.of<NotificationsService>(context);
    return OutlinedButton(
      onPressed: () {
        final scaffold = ScaffoldMessenger.of(context);

        if (!_isSelected) {
          setState(() {
            _isSelected = true;
            resp = notificationsService.agregarProgramas(
                Programa.create(AppStorage.idPlayer, index, hora, elemento));
            if (resp) {
              mensaje = 'Haz agregado el programa $elemento a tu lista';
            } else {
              mensaje = 'Actualmente ya estas subscrito a este programa';
            }
          });
        } else {
          setState(() {
            _isSelected = false;
            resp = notificationsService.eliminarPrograma(
                Programa.create(AppStorage.idPlayer, index, hora, elemento));
            if (resp) {
              mensaje = 'Haz eliminado el programa $elemento tu lista';
            } else {
              mensaje = '';
            }
          });
        }
        (mensaje.isNotEmpty)
            ? scaffold.showSnackBar(
                SnackBar(
                  content: Text(mensaje),
                  duration: const Duration(milliseconds: 800),
                  action: SnackBarAction(
                      label: 'Ocultar',
                      onPressed: scaffold.hideCurrentSnackBar),
                ),
              )
            : null;
      },
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height,
            //color: Colors.blue,
            alignment: Alignment.center,
            child: Text(
              hora,
              style: TextStyle(
                  color: (_isSelected && resp) ? Colors.white : Colors.pink,
                  fontSize: 20),
            ),
          ),
          Text(
            elemento,
          ),
        ],
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        textStyle: const TextStyle(fontSize: 20),
        primary: (_isSelected && resp) ? Colors.white : Colors.pink,
        backgroundColor:
            (_isSelected && resp) ? Colors.purple[400] : Colors.white,
        side: const BorderSide(
          color: Colors.pink,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
    );
  }
}
