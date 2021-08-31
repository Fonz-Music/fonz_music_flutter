import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestSpotifyApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/CoreUserAttributes.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalSessionVariables.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/ActiveSongWidgets/ActiveSongComponent.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/ActiveSongWidgets/ActiveSongView.dart';

import 'NoActiveSongComponent.dart';

class ActiveSongFutureBuilder extends StatefulWidget {
  @override
  _ActiveSongFutureBuilderState createState() => _ActiveSongFutureBuilderState();
}

class _ActiveSongFutureBuilderState extends State<ActiveSongFutureBuilder> {

  Future<ActiveSongDecoder> getActiveSong() async {
    if (activeSongNowPlaying == null || updateActiveSong) {
      final fetchedActiveSong = await GuestSpotifyApi.fetchActiveSong(hostSessionIdGlobal);
      activeSongNowPlaying = fetchedActiveSong["body"];
      log("active song is " + activeSongNowPlaying.toString());
      updateActiveSong = false;
    }

    return activeSongNowPlaying;
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      child: FutureBuilder(
          future: getActiveSong(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Container(
                child: NoActiveSongComponent(),
              );
            }
            else if (snapshot.data == null || snapshot.data.images[0] == null ) {
              log("data is " + snapshot.data.toString());
              return MaterialButton(
                onPressed: () {
                  updateActiveSong = true;
                  setState(() {});
                },
                  child: Container(
                      width: width,
                      child: NoActiveSongComponent()
                  )
              );

            }
            else {
              return
                MaterialButton(
                  onPressed: () {
                    updateActiveSong = true;
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
