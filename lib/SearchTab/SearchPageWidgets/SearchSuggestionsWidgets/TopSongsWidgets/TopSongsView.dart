import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndFunctions.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';

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
          // width: width * 0.95,
          // height: 150,
          child: Column(
            children: [
              Row(
                children: [
                  TopSongComponent(tempTracks[0]),
                  TopSongComponent(tempTracks[1]),
                ],
              ),
              Row(
                children: [
                  TopSongComponent(tempTracks[2]),
                  TopSongComponent(tempTracks[3]),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget TopSongComponent(Track track) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      padding: EdgeInsets.all(5),
      child: MaterialButton(
        onPressed: () {
          log("pressed");
        },
        child: Container(
          width: width * 0.4,
          height: 50,

          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(3, 3), // changes position of shadow
              ),
            ],
            color: determineColorThemeText(),
            borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
          ),
          child: Row(
            children: [
              Container(
              // *---------------Use variable taken from Library selection for album url-----*
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
                  child: Image.network("${track.imageLink}",
                    height: 50,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Column(
                  children: [
                     SizedBox(
                       width: width * 0.25,
                       child: Text(
                            "${track.title}",
                            style: TextStyle(
                              fontFamily: FONZFONTTWO,
                              fontSize: HEADINGSIX,
                              color: determineColorThemeTextInverse(),
                            ),
                            textAlign: TextAlign.left,
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),
                     ),

                     SizedBox(
                       width: width * 0.25,
                       child: Text(
                    // *---------------Use variable taken from Library selection for artist--------*
                          // removes the brackets from the string
                            "${convertArtistArrayToString(track.artist.toString())}",
                            style: TextStyle(
                              fontFamily: FONZFONTONE,
                              fontSize: HEADINGSEVEN,
                              color: determineColorThemeTextInverse(),
                            ),
                            textAlign: TextAlign.left,
                          ),
                     ),

                  ]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
