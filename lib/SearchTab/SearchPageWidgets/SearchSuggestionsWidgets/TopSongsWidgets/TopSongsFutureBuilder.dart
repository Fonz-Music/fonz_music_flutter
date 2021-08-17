import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifyEndpoints/SpotifySuggestionsApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifySuggestionInterpreter.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalFunctions/SpotifyResultsFunctions.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalSessionVariables.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';
import 'package:fonz_music_flutter/main.dart';

import 'TopSongsView.dart';

class TopSongsFutureBuilder extends StatefulWidget {
  @override
  _TopSongsFutureBuilderState createState() => _TopSongsFutureBuilderState();
}

class _TopSongsFutureBuilderState extends State<TopSongsFutureBuilder> {

  Future<List<Track>> getTopSongs() async {
    if (updateTopSongs) {
      log("going to get top songs");
      // change to guest depending
      if (userAttributes.getUserSessionId() != "") {
        log("user has session ");
        final fetchedTopSongs = await SpotifySuggestionsApi.getGuestTopSongs(userAttributes.getUserSessionId());
        log("got top songs");
        var tracks = Items.fromJson(fetchedTopSongs["body"]);
        topSongs = tracksToList([tracks]);
        // log("top songs are " + topSongs.toString());
      }
      // get top Fonz songs
      else {
        log("using host creds");
        final fetchedTopSongs = await SpotifySuggestionsApi.getGuestTopSongs(hostSessionIdGlobal);

        if (fetchedTopSongs["statusCode"] == 200) {
          log("can acc get host creds");
          // log("number of songs is" + fetchedTopSongs["body"].toString());
          var tracks = fetchedTopSongs["body"];
          log("got items from json");
          topSongs = tracksJsonToList(tracks);
        }
        else {
          log("using temp tracks");
          topSongs = tempTracks;
        }
      }
      updateTopSongs = false;
    }

    return topSongs;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      child: FutureBuilder(
          future: getTopSongs(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Container(
                // child: TopSongsView(),
              );
            }
            else if (snapshot.data != null && topSongs.length > 0) {
              log("data is " + snapshot.data.toString());
              return
                TopSongsView(tracks: snapshot.data);

            }
            else {
              return
                Container();
            }

          }
      ),
    );
  }
}
