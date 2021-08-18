import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifyEndpoints/SpotifySuggestionsApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalFunctions/SpotifyResultsFunctions.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalSessionVariables.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Artist.dart';
import 'package:fonz_music_flutter/main.dart';

import 'TopArtistsView.dart';

class TopArtistsFutureBuilder extends StatefulWidget {
  @override
  _TopArtistsFutureBuilderState createState() => _TopArtistsFutureBuilderState();
}

class _TopArtistsFutureBuilderState extends State<TopArtistsFutureBuilder> {

  Future<List<Artist>> getTopArtists() async {
    if (updateTopArtists) {
      log("going to get top songs");
      // change to guest depending
      if (userAttributes.getUserSessionId() != "") {
        log("user has session ");
        final fetchedTopArtists = await SpotifySuggestionsApi.getGuestTopArtists(userAttributes.getUserSessionId());
        log("got top songs");
        var artists = fetchedTopArtists["body"];
        topArtists = artistsJsonToList(artists);

      }
      // get top Fonz songs
      else {
        log("using host creds");
        final fetchedTopArtists = await SpotifySuggestionsApi.getGuestTopArtists(hostSessionIdGlobal);

        if (fetchedTopArtists["statusCode"] == 200) {
          log("can acc get host creds");
          // log("number of songs is" + fetchedTopSongs["body"].toString());
          var artists = fetchedTopArtists["body"];
          log("got artists from json");
          topArtists = artistsJsonToList(artists);
        }
        else {
          log("using temp artists");
          topArtists = tempArtists;
        }
      }
      updateTopArtists = false;
    }

    return topArtists;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getTopArtists(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              log("not done yet");
              return Container(
                // child: TopSongsView(),
              );
            }
            else if (snapshot.data != null) {
              // log("data is " + snapshot.data.toString());
              return
                TopArtistsView(artists: snapshot.data);

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