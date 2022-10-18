// ignore_for_file: prefer_const_constructors

//import 'dart:html';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MUsicApp(),
    );
  }
}

class MUsicApp extends StatefulWidget {
  const MUsicApp({Key? key}) : super(key: key);

  @override
  State<MUsicApp> createState() => _MUsicAppState();
}

const String audioPath =
    'Amar_Bhitor_o_Bahire_-_Flute_(Bansuri)_Cover(256k).mp3';

class _MUsicAppState extends State<MUsicApp> {
  // we  will need some variables
  bool playing = false; //at  the beginig we are not playing any song
  IconData playBtn = Icons.play_arrow; // the main state of play button icon

  // Now  Lets start by creating our music player
  // first lets declare some object
  late AudioPlayer _player;
  late AudioCache cache;

  Duration position = new Duration();
  Duration musicLength = new Duration();

  // we will create a custom slider

  Widget slider() {
    return Slider.adaptive(
        activeColor: Colors.blue,
        inactiveColor: Colors.grey,
        value: position.inSeconds.toDouble(),
        max: musicLength.inSeconds.toDouble(),
        onChanged: (value) {
          seekToSec(value.toInt());
        });
  }

  // lets create the seek function that will allow us to go to a certain position of the music
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  //Now lets initialize our player

  @override
  void initState() {
    //TODO:implement initState
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(prefix: "assets/");

    _player.onDurationChanged.listen((Duration duration) {
      setState(() {
        musicLength = duration;
      });
    });
    _player.onPositionChanged.listen((p) {
      setState(() {
        position = p;
      });
    });

    //cache.load("Amar_Bhitor_o_Bahire_-_Flute_(Bansuri)_Cover(256k).mp3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // lests  start by creating  the  main UI of the App

      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              // ignore: prefer_const_literals_to_create_immutables
              colors: [
                Color.fromARGB(255, 82, 146, 198),
                Color.fromARGB(255, 88, 142, 187),
              ]),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 48.0,
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // lets add some text title
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Music Beats",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Listen to your favorite Music",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),

                // Lets add the music cover

                Center(
                  child: Container(
                    width: 2800.0,
                    height: 280.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        image: DecorationImage(
                          image: AssetImage("assets/pic.jpg"),
                        )),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Center(
                  child: Text(
                    "Sujon",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(38.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Lets start by adding the controller
                        // lets add the time indicator text
                        Container(
                          width: 500.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  "${position.inMinutes}:${position.inSeconds.remainder(60)}"),
                              slider(),
                              Text(
                                  "${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}"),
                            ],
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 45.0,
                              color: Color.fromARGB(255, 78, 158, 223),
                              onPressed: () {},
                              icon: Icon(Icons.skip_previous),
                            ),
                            IconButton(
                              iconSize: 56.0,
                              color: Color.fromARGB(255, 78, 158, 223),
                              onPressed: () {
                                // here we will add the functionality of the play button

                                if (!playing) {
                                  // now lets play the song
                                  _player.play(AssetSource(audioPath));
                                  setState(() {
                                    playBtn = Icons.pause;
                                    playing = true;
                                  });
                                } else {
                                  _player.pause();
                                  setState(() {
                                    playBtn = Icons.play_arrow;
                                    playing = false;
                                  });
                                }
                              },
                              icon: Icon(playBtn),
                            ),
                            IconButton(
                              iconSize: 45.0,
                              color: Color.fromARGB(255, 78, 158, 223),
                              onPressed: () {},
                              icon: Icon(Icons.skip_next),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
