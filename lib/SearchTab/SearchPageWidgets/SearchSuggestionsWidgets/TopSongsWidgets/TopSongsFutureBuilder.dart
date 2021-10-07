import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifyEndpoints/SpotifySuggestionsApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifySuggestionInterpreter.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalFunctions/SpotifyResultsFunctions.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalSessionVariables.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/SearchSuggestionsWidgets/TopSongsWidgets/TopSongComponent.dart';
import 'package:fonz_music_flutter/main.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'TopSongsView.dart';

final _topSongsController = PagingController(
  // 2
  firstPageKey: 0,
);

class TopSongsFutureBuilder extends StatefulWidget {
  @override
  _TopSongsFutureBuilderState createState() => _TopSongsFutureBuilderState();
}

class _TopSongsFutureBuilderState extends State<TopSongsFutureBuilder> {

  Future<List<Track>> getTopSongs() async {
    if (updateTopSongs) {
      log("going to get top songs");
      // change to guest depending
      if (userAttributes.getConnectedToSpotify() && userAttributes.getUserSessionId() != "") {
        log("user has session ");
        final fetchedTopSongs = await SpotifySuggestionsApi.getGuestTopSongs(userAttributes.getUserSessionId());
        log("got top songs");
        var tracks = fetchedTopSongs["body"];
        log("got items from json");
        topSongs = tracksJsonToList(tracks);
      }
      // get top Fonz songs
      else {
        log("using host creds");
        final fetchedTopSongs = await SpotifySuggestionsApi.getGuestTopSongs(hostSessionIdGlobal);

        // if (fetchedTopSongs["statusCode"] == 200) {
        //   log("can acc get host creds");
        //   // log("number of songs is" + fetchedTopSongs["body"].toString());
          var tracks = fetchedTopSongs["body"];
          log("got items from json");
          topSongs = tracksJsonToList(tracks);
        // }
        // else {
        //   log("using temp tracks");
        //   topSongs = tempTracks;
        // }
      }
      updateTopSongs = false;
    }else {
      log("does not need top songs");
    }

    return topSongs;
  }

  @override
  void initState() {
    // 3
    _topSongsController.addPageRequestListener((offset) {
      fetchTopSongs(offset);
    });
    super.initState();
  }

  // @override
  // void dispose() {
  //   // 4
  //   _topSongsController.dispose();
  //   super.dispose();
  // }

  Future<void> fetchTopSongs(int offset) async {
    // TODO: Implement the function's body.
    var songs = await getTopSongs();
    _topSongsController.appendPage(songs, offset);
    offset = offset + 20;
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
                TopSongsView(tracks: tempTracks);
            }

          }
      ),
      // height: 140,
      // padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      // width: width * COMPONENTWIDTH,
      // child:  RefreshIndicator(
      //   onRefresh: () => Future.sync(
      //     // 2
      //         () => _topSongsController.refresh(),
      //   ),
      //   // 3
      //   child: PagedListView.separated(
      //     // 4
      //     scrollDirection: Axis.horizontal,
      //     pagingController: _topSongsController,
      //     padding: const EdgeInsets.all(16),
      //     separatorBuilder: (context, index) => const SizedBox(
      //       height: 16,
      //     ),
      //     builderDelegate: PagedChildBuilderDelegate(
      //       itemBuilder: (context, track, index)  {
      //         // log("track is " + track.toString());
      //         return Column(
      //           children: [
      //             TopSongComponent(track: track),
      //             TopSongComponent(track: track),
      //           ],
      //         );
      //       },
      //       // firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
      //       //   error: _pagingController.error,
      //       //   onTryAgain: () => _pagingController.refresh(),
      //       // ),
      //       noItemsFoundIndicatorBuilder: (context) => Container(child: Text("no songs"),),
      //     ),
      //   ),
      // ),
    );
  }
}
