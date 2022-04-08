import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class RedesPage extends StatelessWidget {
  final title = 'Flutter Vector Icons Gallery';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Colors.purple, Colors.red])),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                  // color: Colors.blue,
                  ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                //  color: Colors.red,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    // color: Colors.black,
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.50,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            // color: Colors.white,
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: MediaQuery.of(context).size.height * 0.09,
                            child: Image.asset('assets/img/logo.png'),
                          ),
                        ),
                        Container(
                          // color: Colors.orange,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.13,
                          child: const FittedBox(
                            child: Text(
                              'SIGUENOS',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Fredes',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // color: Colors.blue,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: const FittedBox(
                            child: Text(
                              'EN NUESTRAS REDES SOCIALES',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'FDredes',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // color: Colors.green,
                          alignment: Alignment.topCenter,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.09,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FittedBox(
                                child: IconButton(
                                  onPressed: () {
                                    launch(
                                        'https://www.facebook.com/RadioCUCEI');
                                  },
                                  icon: const Icon(Icons.facebook,
                                      size: 50, color: Colors.white),
                                  tooltip: 'Facebook',
                                ),
                              ),
                              FittedBox(
                                child: IconButton(
                                  onPressed: () {
                                    launch(
                                        'https://www.youtube.com/user/radiocuceifm/videos');
                                  },
                                  icon: const Icon(FontAwesome.youtube_play,
                                      size: 50, color: Colors.white),
                                  tooltip: 'Youtube',
                                ),
                              ),
                              FittedBox(
                                child: IconButton(
                                  onPressed: () {
                                    launch(
                                        'https://soundcloud.com/radiocuceifm');
                                  },
                                  icon: const Icon(FontAwesome.soundcloud,
                                      size: 50, color: Colors.white),
                                  tooltip: 'soundcloud',
                                ),
                              ),
                              FittedBox(
                                child: IconButton(
                                  onPressed: () {
                                    launch(
                                        'https://www.instagram.com/RadioCucei/');
                                  },
                                  icon: const Icon(Ionicons.logo_instagram,
                                      size: 50, color: Colors.white),
                                  tooltip: 'Instagram',
                                ),
                              ),
                              FittedBox(
                                child: IconButton(
                                  onPressed: () {
                                    launch('https://twitter.com/RadioCUCEIFM');
                                  },
                                  icon: const Icon(Ionicons.logo_twitter,
                                      size: 50, color: Colors.white),
                                  tooltip: 'Twitter',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                  // color: Colors.purple,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
