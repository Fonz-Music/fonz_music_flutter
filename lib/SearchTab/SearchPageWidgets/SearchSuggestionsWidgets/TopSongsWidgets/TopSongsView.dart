import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';

import 'TopSongComponent.dart';

class TopSongsView extends StatefulWidget {
  @override
  _TopSongsViewState createState() => _TopSongsViewState();
}

class _TopSongsViewState extends State<TopSongsView> {
  
  var tempTracks = [
    Track("Boyfriend", [" Big Time Rush"], "1rKBOL9kJfX1Y4C3QaOvRH", "https://i.scdn.co/image/ab67616d0000b27350acd1f66ebd5b84630c7129"),
    Track.withUrl("Is It True", ["Tame Impala"], "6RZmhpvukfyeSURhf4kZ0d", "https://i.scdn.co/image/ab67616d0000b27358267bd34420a00d5cf83a49", "https://open.spotify.com/track/6RZmhpvukfyeSURhf4kZ0d"),
    Track.withUrl("The Spirit Of Radio", ["Rush"], "4e9hUiLsN4mx61ARosFi7p", "https://i.scdn.co/image/ab67616d0000b27306c0d7ebcabad0c39b566983", "https://open.spotify.com/track/4e9hUiLsN4mx61ARosFi7p"),
    Track.withUrl("Limelight", ["Rush"], "0K6yUnIKNsFtfIpTgGtcHm", "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),
  ];
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 0, 10),
              child: new Text(
                "your top songs",
                style: TextStyle(
                  fontFamily: FONZFONTTWO,
                  fontSize: HEADINGFIVE,
                  color: determineColorThemeTextInverse(),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Spacer()
          ],
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          width: width,
          // height: 150,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TopSongComponent(track: tempTracks[0]),
                  TopSongComponent(track: tempTracks[1]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TopSongComponent(track: tempTracks[2]),
                  TopSongComponent(track: tempTracks[3]),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
