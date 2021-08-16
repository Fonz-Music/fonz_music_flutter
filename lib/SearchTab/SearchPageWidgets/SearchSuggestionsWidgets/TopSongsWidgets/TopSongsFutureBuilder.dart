import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifyEndpoints/SpotifySuggestionsApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalSessionVariables.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';
import 'package:fonz_music_flutter/main.dart';

class TopSongFutureBuilder extends StatefulWidget {
  @override
  _TopSongFutureBuilderState createState() => _TopSongFutureBuilderState();
}

class _TopSongFutureBuilderState extends State<TopSongFutureBuilder> {

  Future<List<Track>> getTopSong() async {
    if (topSongs == null || updateTopSongs) {
      // change to guest depending
      // if ()
      final fetchedActiveSong = await SpotifySuggestionsApi.getGuestTopSongs(hostSessionIdGlobal);
      topSongs = fetchedActiveSong["body"];
      log("active song is " + topSongs.toString());
      updateTopSongs = false;
    }

    return topSongs;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
