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
    Track.withUrl("Prune, You Talk Funny", [" Gus Dapperton"], "6sHCvZe1PHrOAuYlwTLNH4",  "https://i.scdn.co/image/ab67616d0000b273ba8dea5129b6e43b59fadad7", "https://open.spotify.com/track/6sHCvZe1PHrOAuYlwTLNH4"),
    Track.withUrl("Supalonely", [" BENEE"], "3GZoWLVbmxcBys6g0DLFLf",   "https://i.scdn.co/image/ab67616d0000b2734bd20e01d00de4b35b61f5f7",  "https://open.spotify.com/track/3GZoWLVbmxcBys6g0DLFLf"),
    Track.withUrl("Post Humorous", [" Gus Dapperton"], "0yb9DKhu0xA0h0qvKOHVwu",   "https://i.scdn.co/image/ab67616d0000b2731dc1bd83254e89b474ca496b",  "https://open.spotify.com/track/0yb9DKhu0xA0h0qvKOHVwu"),
    Track.withUrl("I\'m Just Snacking", [" Gus Dapperton"], "6413UUgINHbZsCJeJBFlmT",    "https://i.scdn.co/image/ab67616d0000b27303c5191d01d37d5c795697df",  "https://open.spotify.com/track/6413UUgINHbZsCJeJBFlmT"),
    Track.withUrl("Palms (with Channel Tres)", [" Gus Dapperton Channel Tres"], "0Lskej1hiep1PKXoz7KhyO", "https://i.scdn.co/image/ab67616d0000b273fd9c5111af2d35d22fb4a512",  "https://open.spotify.com/track/0Lskej1hiep1PKXoz7KhyO"),
    Track.withUrl("Somewhere (feat. Gus Dapperton)", [" Surf Mesa Gus Dapperton"], "0bmQ5H9mHFzRnJ4ZntylFg",  "https://i.scdn.co/image/ab67616d0000b273ba3286704e1aec6a762ab144",  "https://open.spotify.com/track/0bmQ5H9mHFzRnJ4ZntylFg"),
    Track.withUrl("Medicine", [" Gus Dapperton"], "7lLtAjBc4Fkaw0FkBQWlSX",   "https://i.scdn.co/image/ab67616d0000b2731dc1bd83254e89b474ca496b",  "https://open.spotify.com/track/7lLtAjBc4Fkaw0FkBQWlSX"),
    Track.withUrl("I\'m On Fire", [" Gus Dapperton"], "0lhcKPk0fppMAnFUt3QNy7",   "https://i.scdn.co/image/ab67616d0000b273ada32af03830941f2b510bd9", "https://open.spotify.com/track/0lhcKPk0fppMAnFUt3QNy7"),];
  
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
            itemCount: tempTracks.length ~/2,
            itemBuilder: (BuildContext context, int index) {
              // child:

              return Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  TopSongComponent(track: tempTracks[index]),
                  TopSongComponent(track: tempTracks[index + tempTracks.length ~/2]),
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
