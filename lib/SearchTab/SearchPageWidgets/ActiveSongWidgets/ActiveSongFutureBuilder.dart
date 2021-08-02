import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestSpotifyApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/CoreUserAttributes.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/ActiveSongWidgets/ActiveSongComponent.dart';

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
    return Container(
      child: FutureBuilder(
          future: getTopSong(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Container(
                child: Text("no song active"),
              );
            }
            else if (snapshot.data.trackName == null || snapshot.data.trackName == "" ) {
              log("data is " + snapshot.data.toString());
              return Container(child: ActiveSongComponent(track: snapshot.data));

            }
            else {
              return Container(child: ActiveSongComponent(track: snapshot.data));
            }

          }
      ),
    );
  }
}
