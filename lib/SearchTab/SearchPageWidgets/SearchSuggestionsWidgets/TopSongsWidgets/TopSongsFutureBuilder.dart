import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifyEndpoints/SpotifySuggestionsApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifySuggestionInterpreter.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalFunctions/SpotifyResultsFunctions.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalSessionVariables.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';
import 'package:fonz_music_flutter/main.dart';

import 'TopSongsView.dart';

class TopSongFutureBuilder extends StatefulWidget {
  @override
  _TopSongFutureBuilderState createState() => _TopSongFutureBuilderState();
}

class _TopSongFutureBuilderState extends State<TopSongFutureBuilder> {

  Future<List<Track>> getTopSongs() async {
    if (topSongs == null || updateTopSongs) {
      // change to guest depending
      if (userAttributes.getUserSessionId() != null) {
        final fetchedTopSongs = await SpotifySuggestionsApi.getGuestTopSongs(userAttributes.getUserSessionId());
        var tracks = SpotifySearchResponse.fromJson(fetchedTopSongs["body"]);
        topSongs = tracksToList(tracks.tracks.items);
        log("top songs are " + topSongs.toString());
      }
      else {
        final fetchedTopSongs = await SpotifySuggestionsApi.getGuestTopSongs(hostSessionIdGlobal);
        var tracks = SpotifySearchResponse.fromJson(fetchedTopSongs["body"]);
        if (tracks == null || tracks.tracks.items.length > 0) {
          topSongs = tracksToList(tracks.tracks.items);
        }
        else {
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
            else if (snapshot.data == null ) {
              log("data is " + snapshot.data.toString());
              return MaterialButton(
                  onPressed: () {
                    updateActiveSong = true;
                    setState(() {});
                  },
                  child: Container(
                      width: width,
                      // child: NoActiveSongComponent()
                  )
              );

            }
            else {
              return
                TopSongsView(tracks: topSongs);
            }

          }
      ),
    );
  }
}
