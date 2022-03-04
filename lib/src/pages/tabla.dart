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
                child: Container(
                 
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
       
      )
     
      
        );
        
  }
 //https://www.woolha.com/tutorials/flutter-using-datatable-widget-examples
  DataTable generarHorario(List<dynamic> resultado){
    return DataTable( 
      headingRowColor: MaterialStateColor.resolveWith((states) => Colors.purple.withOpacity(0.5)),
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
                color: MaterialStateProperty.all(Colors.white.withOpacity(0.75)),
                cells: [for(String elemento in fila) DataCell(Text(elemento, style: TextStyle(color: Colors.pink),))])],  
            );
  }

  Column generarFormulario(List<dynamic> resultado) {
    return Column(
          children: <Widget>[
           

          Container( 
            height: MediaQuery.of(context).size.height*0.70,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height*0.05,
                            bottom: 10,
                          ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: generarHorario(resultado),
                ),
                
              ),
              
              ),
          
            
            MultiSelectDialogField(
              items: itemsHorario,
              title: const Text("Disponibilidad de Programas"),
              selectedColor: Colors.pink,
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                border: Border.all(
                  color: Colors.pink,
                  width: 2,
                ),
              ),
              buttonIcon: const Icon(
                Icons.schedule,
                color: Colors.white,
              ),
              buttonText: Text(
                "Consultar Horarios",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
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