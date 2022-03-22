import 'package:flutter/material.dart';
import 'package:radiocucei/src/widgets/widgets.dart';

class Notifi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Notificaciones'),
      ),
      body: Center(child: SusbscriptionTile(child: Text('Hola mundo'))),
    );
  }
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