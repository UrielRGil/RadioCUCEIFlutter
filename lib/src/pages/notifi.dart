import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radiocucei/src/services/notificaciones_service.dart';
import 'package:radiocucei/src/widgets/widgets.dart';

//TODO: Implementar estilo al IconButton
// TODO: Implementar estilo a las fuentes

class Notifi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificationsService = Provider.of<NotificationsService>(context);
    final programs = notificationsService.programas;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Notificaciones'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.purple, Colors.red])),
        child: FutureBuilder(
          future: notificationsService.obtenerNotificaciones(),
          initialData: const [],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                final programa = programs[index];
                return SubscriptionTile(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(programa.nombrePrograma, style: _customTextStyle()),
                      Text(
                        programa.horario,
                        style: _customTextStyle(),
                      ),
                    ],
                  ),
                ));
              },
              itemCount: programs.length,
            );
          },
        ),
      ),
    );
  }

  TextStyle _customTextStyle() => TextStyle(color: Colors.white, fontSize: 20);
}

/*
class SingleChildScrollViewWidget extends StatelessWidget {
  final controller = ScrollController();
  var alphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("SingleChildScroll Widget"),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        color: Colors.blue,
        child: Align(
          child: Container(
          color: Colors.white,
          width: 400,
          height: 400,
          child: Column(
            children: [
              Container(
                color: Colors.red,
                width: 500,
                height: 100,),

                Align(
                  heightFactor: 0.02,
                  child:  Container(
                color: Colors.purple,
                width: 5,
                height: 100,),),
            ],)
          ),

        ), 
        
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        scrollUp();
      }),
    ));
  }

  horizontalScroll() {
    return SingleChildScrollView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      child: Center(
        child: Row(
          children: alphabets
              .split("")
              .map((a) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      a,
                      style: TextStyle(fontSize: 20, color: Colors.pink),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  verticalScroll() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Column(
          children: alphabets
              .split("")
              .map((a) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      a,
                      style: TextStyle(fontSize: 20, color: Colors.pink),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  void scrollUp() {
    final double start = 500.0;
    controller.jumpTo(start);
  }
}
*/