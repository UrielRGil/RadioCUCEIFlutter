import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:radiocucei/src/componentes/utils.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';



class TablaPage extends StatefulWidget {

  @override
  createState(){
    return  _TablaPageState();
  }

}

class _TablaPageState extends State<TablaPage> {
final List<MultiSelectItem<String?>> itemsHorario = [];
  late Future<Horario> futureHorario;
  List<dynamic> h = [];

  @override
  void initState() {
    futureHorario = fetchHorario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: 
      Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [Colors.purple, Colors.red]
                  )
                ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  child: FutureBuilder<Horario>(
                    future: futureHorario,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        h = snapshot.data!.filas;
                        h.forEach((fila) {completarFilas(fila);});
                        final Map<String, dynamic> disponibilidad = generarDisponibilidad(h);
                        //Iterar sobre programa
                        disponibilidad.forEach((k, v){
                          //Iterar sobre dias de ese programa
                          v.forEach((k1, v1){
                            //Iterar sobre horas de ese programa
                            v1.forEach((elemento){
                              itemsHorario.add(MultiSelectItem<String>("$k el $k1 a las $elemento", "$k el $k1 a las $elemento"));
                            });
                          });
                        });
                        print("LISTO");
                        return generarFormulario(h);
                      }
                      else if(snapshot.hasError){
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                      ),
                  ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
        generarFormulario(h);
      }),
      )
     
      
        );
        
  }
 //https://www.woolha.com/tutorials/flutter-using-datatable-widget-examples
  DataTable generarHorario(List<dynamic> resultado){
    return DataTable( 
      headingRowColor: MaterialStateColor.resolveWith((states) => Colors.purple),
              columns: [
                DataColumn(label: Text(  
                    'Hora',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, ),
                    textAlign: TextAlign.center,
                    
                )),  
                DataColumn(label: Text(  
                    'L',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                    textAlign: TextAlign.center,
                )),  
                DataColumn(label: Text(  
                    'M',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                    textAlign: TextAlign.center,  
                )),  
                DataColumn(label: Text(  
                    'I',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                    textAlign: TextAlign.center, 
                )),
                DataColumn(label: Text(  
                    'J',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                    textAlign: TextAlign.center, 
                )),
                DataColumn(label: Text(  
                    'V',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                    textAlign: TextAlign.center, 
                )),
                DataColumn(label: Text(  
                    'S',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                    textAlign: TextAlign.center, 
                )),
                DataColumn(label: Text(  
                    'D',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                    textAlign: TextAlign.center, 
                )),
              ],  
              rows: [ for(List<dynamic> fila in resultado) DataRow(
                color: MaterialStateProperty.all(Colors.white),
                cells: [for(String elemento in fila) DataCell(Text(elemento, style: TextStyle(color: Colors.red),))])],  
            );
  }

  Column generarFormulario(List<dynamic> resultado) {
    return Column(
          children: <Widget>[
            generarHorario(resultado),
            MultiSelectDialogField(
              items: itemsHorario,
              title: const Text("Disponibilidad de Programas"),
              selectedColor: Colors.blue,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
              buttonIcon: const Icon(
                Icons.schedule,
                color: Colors.blue,
              ),
              buttonText: Text(
                "Consultar Horarios",
                style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 16,
                ),
              ),
              onConfirm: (List<String?> results) {
                results.forEach((element) {print(element);});
              },
            ),
                ],
              );
  }


}