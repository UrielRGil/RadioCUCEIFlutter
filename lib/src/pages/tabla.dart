import 'package:flutter/material.dart';

class TablaPage extends StatefulWidget {

  @override
  createState(){
    return  _TablaPageState();
  }

}

class _TablaPageState extends State<TablaPage> {

 final _estiloTexto = TextStyle(fontSize: 25);
 
 
 
 @override
  Widget build(context){
    return Scaffold(

      body: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
             begin: Alignment.bottomRight,
                end: Alignment.topLeft,
            colors: [Colors.purple, Colors.red])
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               Container(
                margin: EdgeInsets.all(MediaQuery.of(context).size.width *0.2),
                //color: Colors.white,
                width: MediaQuery.of(context).size.width *0.45,
                height: MediaQuery.of(context).size.height *0.23,
                child: Image.asset('assets/img/logo.png'),
                ),
              Text("Contador de taps :", style: _estiloTexto,
              ),

            ],),
        

        ),
        
      
     
    
   );

  }

 
 



}