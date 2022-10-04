import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radiocucei/src/services/audio_player_handler.dart';
import 'package:radiocucei/src/widgets/widgets.dart';

class InicioPage extends StatefulWidget {
  final AudioPlayerHandler audioHandler;

  const InicioPage({Key? key, required this.audioHandler}) : super(key: key);
  @override
  createState() {
    return _InicioPageState();
  }
}

class _InicioPageState extends State<InicioPage>
    with AutomaticKeepAliveClientMixin {
  List<double> item = [];
  final controller = ScrollController();

  AudioPlayer audioPlayer = AudioPlayer();
  bool playing = false, dato = false, play = false, banderastring = false;
  int punta = 0;
  int puntad = 0;
  double start = 0.00, x = -1.00;
  String estacion = '0';

  @override
  void initState() {
    item = List.generate(11, (index) => index.toDouble());
    super.initState();
  }

  @override
  Widget build(context) {
    final _audioHandler = widget.audioHandler;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Colors.purple, Colors.red])),
        child: Column(
          children: [
            //contenedor superior
            SafeArea(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.09,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // color: Colors.blue,
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.height * 0.08,
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
                      ),
                      child: const Image(
                        image: AssetImage('assets/img/radiocucei.gif'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      //color: Colors.green,
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.50,
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
                      ),

                      child: const FittedBox(
                        child: Text(
                          'FM Radio',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.20,
                      alignment: Alignment.topCenter,
                      child: StreamBuilder(
                          stream: _audioHandler.playbackState
                              .map((state) => state.playing)
                              .distinct(),
                          builder: (context, snapshot) {
                            final playing = (snapshot.data ?? false) as bool;
                            if (playing) {
                              return ActionButton(
                                  icon: Icons.pause,
                                  onPressed: _audioHandler.pause);
                            } else {
                              return ActionButton(
                                  icon: Icons.play_arrow,
                                  onPressed: _audioHandler.play);
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),

            //contenedor medio
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.53,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.32,
                    // color: Colors.amberAccent,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.43,
                          height: MediaQuery.of(context).size.height * 0.43,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // color: Colors.blueGrey,
                            border: Border.all(
                              width: 5,
                              color: Colors.white,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.28,
                              height: MediaQuery.of(context).size.height * 0.10,
                              child: FittedBox(
                                child: Text(
                                  _audioHandler.estacion,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width,
                    child: const FittedBox(
                      child: Text(
                        'Radio CUCEI',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  StreamBuilder<IcyMetadata?>(
                    stream: _audioHandler.player.icyMetadataStream,
                    builder: (context, snapshot) {
                      final metadata = snapshot.data;
                      final title = metadata?.info?.title ?? '';

                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Text(
                            title,
                            style: TextStyle(
                                color: Colors.pink.shade900,
                                fontSize: 23.5,
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.center,
                          ),
                          //),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            //contenedor inferior
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.pink.shade900,
                          width: 1,
                        ),
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      reverse: dato,
                      controller: controller,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          item.length,
                          (index) => Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      '|',
                                      style: TextStyle(
                                        color: Colors.pink.shade900,
                                        fontSize: 50,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    for (puntad = 0; puntad <= 8; puntad++)
                                      retorno(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.04,
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          reverse: dato,
                          controller: controller,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              item.length,
                              (index) => Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Center(
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          '${index * 10}',
                                          style: TextStyle(
                                            color: Colors.pink.shade900,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        if (index == 8)
                                          for (punta = 0; punta <= 4; punta++)
                                            Container(
                                              // color: Colors.black,
                                              height: 20,
                                              width: 25,
                                              alignment: Alignment.centerRight,
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          heightFactor: 0.0,
                          alignment: Alignment(x, 1.00),
                          child: Container(
                            color: Colors.pink,
                            width: 5,
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scrollUp() {
    start = MediaQuery.of(context).size.width * 4.19;
    controller.animateTo(
      start,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }

  Text retorno() {
    return const Text(
      '|',
      style: TextStyle(fontSize: 20, color: Colors.white),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
