import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifyEndpoints/SpotifyPaginatedApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalFunctions/SpotifyResultsFunctions.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalSessionVariables.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Artist.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/SearchSuggestionsWidgets/TopArtistsWidgets/ArtistComponent.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../main.dart';

int artistOffset = 0;

final _topArtistsController = PagingController(
  // 2
  firstPageKey: 0,
);

class TopArtistsView extends StatefulWidget {

  TopArtistsView({Key key, this.artists}) : super(key: key);
  List<Artist> artists;

  @override
  _TopArtistsViewState createState() => _TopArtistsViewState();
}

class _TopArtistsViewState extends State<TopArtistsView> {

  @override
  void initState() {
    // 3
    _topArtistsController.addPageRequestListener((offset) {
      fetchTopPlaylists();
      // offset = offset + 8;
    });
    super.initState();
  }

  @override
  void dispose() {
    // 4
    _topArtistsController.dispose();
    super.dispose();
  }

  Future<void> fetchTopPlaylists() async {
    // TODO: Implement the function's body.
    updateTopArtists = true;
    var playlists = await getTopArtists();
    _topArtistsController.appendPage(playlists, artistOffset);
    artistOffset += 10;
  }

  Future<List<Artist>> getTopArtists() async {
    if (updateTopArtists) {
      log("going to get top songs");
      // change to guest depending
      if (userAttributes.getConnectedToSpotify() && userAttributes.getUserSessionId() != "") {
        log("user has session ");
        // final fetchedTopArtists = await SpotifySuggestionsApi.getGuestTopArtists(userAttributes.getUserSessionId());
        final fetchedTopArtists = await SpotifyPaginatedApi.getGuestTopArtistsPaginated(userAttributes.getUserSessionId(), artistOffset);

        log("got top songs");
        var artists = fetchedTopArtists["body"];
        topArtists = artistsJsonToList(artists);

      }
      // get top Fonz songs
      else {
        topArtists = tempArtists;
      }
      updateTopArtists = false;
    }

    return topArtists;
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
              padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: new Text(
                "your favorite artists",
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
          width: width * COMPONENTWIDTH,
          height: 155,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: SHADOWGREY,
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(3, 3), // changes position of shadow
              ),
            ],
            color: determineColorThemeText(),
            borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            // child: ListView.separated(
            //   scrollDirection: Axis.horizontal,
            //   itemCount: widget.artists.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     return ArtistComponent(givenArtist: widget.artists[index]);
            //   },
            //   separatorBuilder: (BuildContext context,
            //       int index) => const Divider(),
            // ),
            child:  RefreshIndicator(
              onRefresh: () => Future.sync(
                // 2
                    () => _topArtistsController.refresh(),
              ),
              // 3
              child: PagedListView.separated(
                // 4
                scrollDirection: Axis.horizontal,
                pagingController: _topArtistsController,
                padding: const EdgeInsets.all(16),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (context, artist, index)  {
                    // log("track is " + track.toString());
                    return ArtistComponent(givenArtist: artist);
                  },
                  // firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
                  //   error: _pagingController.error,
                  //   onTryAgain: () => _pagingController.refresh(),
                  // ),
                  noItemsFoundIndicatorBuilder: (context) => Container(child: Text("no songs"),),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
