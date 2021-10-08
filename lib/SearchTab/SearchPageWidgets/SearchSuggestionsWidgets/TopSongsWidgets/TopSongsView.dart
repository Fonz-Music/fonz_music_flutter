import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifyEndpoints/SpotifyPaginatedApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalFunctions/SpotifyResultsFunctions.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalSessionVariables.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../main.dart';
import 'TopSongComponent.dart';

final _topGuestSongsController = PagingController(
  // 2
  firstPageKey: 0,
);

int topSongsOffset = 0;
// int bottomGuestSongsOffset = 0;

class TopSongsView extends StatefulWidget {

  TopSongsView({Key key, this.tracks}) : super(key: key);
  List<Track> tracks;

  @override
  _TopSongsViewState createState() => _TopSongsViewState();
}

class _TopSongsViewState extends State<TopSongsView> {

  Future<List<Track>> getTopSongs() async {
    log("offset " + topSongsOffset.toString());
    if (updateTopSongs) {
      log("going to get top songs");
      // change to guest depending
      if (userAttributes.getConnectedToSpotify() && userAttributes.getUserSessionId() != "") {
        log("user has session ");
        final fetchedTopSongs = await SpotifyPaginatedApi.getGuestTopSongsPaginated(userAttributes.getUserSessionId(), topSongsOffset);
        log("got top songs");
        var tracks = fetchedTopSongs["body"];
        log("got items from json");
        topSongs = tracksJsonToList(tracks);
      }
      // get top Fonz songs
      else {
        topSongs = tempTracks;
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
    _topGuestSongsController.addPageRequestListener((offset) async {
      await fetchTopSongs();
      // _bottomGuestSongsController.addPageRequestListener((offset) {
      //   fetchTopSongs();
      // });
    });

    super.initState();
  }

  // @override
  // void dispose() {
  //   // 4
  //   _topGuestSongsController.dispose();
  //
  //   super.dispose();
  // }

  Future<void> fetchTopSongs() async {
    updateTopSongs = true;
    var topTracks = await getTopSongs();
    // topSongsOffset = topSongsOffset + 10;
    // var bottomTracks = await getTopSongs(topSongsOffset);
    List<List<Track>> doubleTracks = [];
    for (int i = 0; i < topTracks.length; i += 2) {
      log("track is " + topTracks[i].title + " index is " + i.toString());
      var tracksTogether = [topTracks[i], topTracks[i + 1]];
      doubleTracks.add(tracksTogether);
    }
    log("just did double tracks");
    log(doubleTracks.toString());
    // var modulus = topSongsOffset / 10;
    // log("modulus is " + modulus.toString());
    // log("top songs is " + topSongsOffset.toString());
    // if (modulus == 0 || modulus.toInt().isEven) {
      _topGuestSongsController.appendPage(doubleTracks, topSongsOffset);
    // }
    // else {
    //   _bottomGuestSongsController.appendPage(songs, topSongsOffset);
    // }

    topSongsOffset += 20;
  }


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
          height: 160,
          child:
             RefreshIndicator(
                onRefresh: () => Future.sync(
                  // 2
                      () => _topGuestSongsController.refresh(),
                ),
                // 3
                child: PagedListView.separated(
                  // 4
                  scrollDirection: Axis.horizontal,
                  pagingController: _topGuestSongsController,
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                  builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (context, doubleTracks, index)  {
                      log("track is " + doubleTracks[0].title.toString());
                      return Column(
                        children: [
                          TopSongComponent(track: doubleTracks[0]),
                          TopSongComponent(track: doubleTracks[1]),
                        ],
                      );
                    },
                    noItemsFoundIndicatorBuilder: (context) => Container(child: Text("no songs"),),
                  ),
                ),
              ),
          // child: ListView.builder(
          //
          //   scrollDirection: Axis.horizontal,
          //   // itemCount: 4,
          //   itemCount: widget.tracks.length ~/2,
          //   itemBuilder: (BuildContext context, int index) {
          //     // child:
          //
          //     return Column(
          //       children: [
          //         TopSongComponent(track: widget.tracks[index]),
          //         TopSongComponent(track: widget.tracks[index + widget.tracks.length ~/2]),
          //       ],
          //     );
          //   },
          //   // separatorBuilder: (BuildContext context,
          //   //     int index) =>  Container()
          // ),
        ),
      ],
    );
  }
}
