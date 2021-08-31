import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalSessionVariables.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';

import 'TopSongComponent.dart';

class TopSongsView extends StatefulWidget {

  TopSongsView({Key key, this.tracks}) : super(key: key);
  List<Track> tracks;

  @override
  _TopSongsViewState createState() => _TopSongsViewState();
}

class _TopSongsViewState extends State<TopSongsView> {
  

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
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          width: width * COMPONENTWIDTH,
          height: 140,
          child: ListView.builder(

            scrollDirection: Axis.horizontal,
            // itemCount: 4,
            itemCount: widget.tracks.length ~/2,
            itemBuilder: (BuildContext context, int index) {
              // child:

              return Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  TopSongComponent(track: widget.tracks[index]),
                  TopSongComponent(track: widget.tracks[index + widget.tracks.length ~/2]),
                  // Row(
                  //
                  //   // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //
                  //     // TopSongComponent(track: tempTracks[1]),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     TopSongComponent(track: tempTracks[index + tempTracks.length ~/2]),
                  //     // TopSongComponent(track: tempTracks[3]),
                  //   ],
                  // ),
                ],
              );
            },
            // separatorBuilder: (BuildContext context,
            //     int index) =>  Container()
          ),
        ),
      ],
    );
  }
}
