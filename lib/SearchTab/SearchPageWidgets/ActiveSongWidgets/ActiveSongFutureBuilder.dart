import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestSpotifyApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/CoreUserAttributes.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/ActiveSongWidgets/ActiveSongComponent.dart';

import 'NoActiveSongComponent.dart';

class ActiveSongFutureBuilder extends StatefulWidget {
  @override
  _ActiveSongFutureBuilderState createState() => _ActiveSongFutureBuilderState();
}

class _ActiveSongFutureBuilderState extends State<ActiveSongFutureBuilder> {

  Future<ActiveSongDecoder> getTopSong() async {
    final activeSong = await GuestSpotifyApi.fetchActiveSong(hostSessionIdGlobal);
    log("active song is " + activeSong["body"].toString());
    return activeSong["body"];
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      child: FutureBuilder(
          future: getTopSong(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Container(
                child: NoActiveSongComponent(),
              );
            }
            else if (snapshot.data == null || snapshot.data.trackName == "" ) {
              log("data is " + snapshot.data.toString());
              return MaterialButton(
                onPressed: () {
                  setState(() {});
                },
                  child: Container(
                      width: width,
                      child: ActiveSongComponent(track: snapshot.data)
                  )
              );

            }
            else {
              return
                MaterialButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Container(
                    width: width,
                    child: ActiveSongComponent(track: snapshot.data))
                );
            }

          }
      ),
    );
  }
}
