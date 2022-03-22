import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:radiocucei/src/widgets/widgets.dart';

//TODO: Implementar estilo al IconButton
// TODO: Implementar estilo a las fuentes

class Notifi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
            child: Column(
          children: [
            SusbscriptionTile(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Nombre del programa'),
                    const Text('Horario'),
                    IconButton(
                        onPressed: () {}, icon: const FaIcon(FontAwesome.trash))
                  ],
                ),
              ),
            ),
            SusbscriptionTile(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Nombre del programa'),
                    const Text('Horario'),
                    IconButton(
                        onPressed: () {}, icon: const FaIcon(FontAwesome.trash))
                  ],
                ),
              ),
            ),
            SusbscriptionTile(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Nombre del programa'),
                    const Text('Horario'),
                    IconButton(
                        onPressed: () {}, icon: const FaIcon(FontAwesome.trash))
                  ],
                ),
              ),
            ),
            SusbscriptionTile(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Nombre del programa'),
                    const Text('Horario'),
                    IconButton(
                        onPressed: () {}, icon: const FaIcon(FontAwesome.trash))
                  ],
                ),
              ),
            ),
            SusbscriptionTile(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Nombre del programa'),
                    const Text('Horario'),
                    IconButton(
                        onPressed: () {}, icon: const FaIcon(FontAwesome.trash))
                  ],
                ),
              ),
            ),
            SusbscriptionTile(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Nombre del programa'),
                    const Text('Horario'),
                    IconButton(
                        onPressed: () {}, icon: const FaIcon(FontAwesome.trash))
                  ],
                ),
              ),
            ),
            SusbscriptionTile(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Nombre del programa'),
                    const Text('Horario'),
                    IconButton(
                        onPressed: () {}, icon: const FaIcon(FontAwesome.trash))
                  ],
                ),
              ),
            ),
            SusbscriptionTile(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Nombre del programa'),
                    const Text('Horario'),
                    IconButton(
                        onPressed: () {}, icon: const FaIcon(FontAwesome.trash))
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
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