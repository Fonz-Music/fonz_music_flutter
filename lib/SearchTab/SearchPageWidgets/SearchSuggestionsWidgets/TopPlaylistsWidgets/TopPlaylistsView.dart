import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifyEndpoints/SpotifyPaginatedApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifyEndpoints/SpotifySuggestionsApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalFunctions/SpotifyResultsFunctions.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalSessionVariables.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Playlist.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../main.dart';
import 'PlaylistComponent.dart';

int playlistOffset = 0;

final _topPlaylistsController = PagingController(
  // 2
  firstPageKey: 0,
);

class TopPlaylistsView extends StatefulWidget {

  TopPlaylistsView({Key key, this.playlists}) : super(key: key);
  List<Playlist> playlists;

  @override
  _TopPlaylistsViewState createState() => _TopPlaylistsViewState();
}

class _TopPlaylistsViewState extends State<TopPlaylistsView> {

  @override
  void initState() {
    // 3
    _topPlaylistsController.addPageRequestListener((offset) {
      fetchTopPlaylists();
      // offset = offset + 8;
    });
    super.initState();
  }

  @override
  void dispose() {
    // 4
    _topPlaylistsController.dispose();
    super.dispose();
  }

  Future<void> fetchTopPlaylists() async {
    // TODO: Implement the function's body.
    updateTopPlaylists = true;
    var playlists = await getTopPlaylists(playlistOffset);
    _topPlaylistsController.appendPage(playlists, playlistOffset);
    playlistOffset += 8;
  }

  Future<List<Playlist>> getTopPlaylists(int offset) async {
    if (updateTopPlaylists) {
      log("going to get top playlists");
      // change to guest depending
      if (userAttributes.getConnectedToSpotify() && userAttributes.getUserSessionId() != "") {
        log("user has session ");
        // final fetchedTopPlaylists = await SpotifySuggestionsApi
        //     .getGuestTopPlaylists(userAttributes.getUserSessionId());
        final fetchedTopPlaylists = await
            SpotifyPaginatedApi.getGuestTopPlaylistsPaginated(userAttributes.getUserSessionId(), offset);
        // offset = offset + 8;
        log("got top songs");
        var playlists = fetchedTopPlaylists["body"];
        log("got items from json");
        topPlaylists = playlistsJsonToList(playlists);
      }
      // get top Fonz songs
      else {
        // log("using host creds");
        // final fetchedTopPlaylists = await SpotifySuggestionsApi
        //     .getGuestTopPlaylists(hostSessionIdGlobal);
        // var playlists = fetchedTopPlaylists["body"];
        // log("got items from json");
        // topPlaylists = playlistsJsonToList(playlists);
        topPlaylists = tempPlaylists;
      }
      updateTopPlaylists = false;
    } else {
      log("does not need top playlists");
    }

    return topPlaylists;
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
                "your top playlists",
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
          height: 225,
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
            //
            //   scrollDirection: Axis.horizontal,
            //   itemCount: widget.playlists.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     return PlaylistComponent(givenPlaylist: widget.playlists[index]);
            //   },
            //   separatorBuilder: (BuildContext context,
            //       int index) => const Divider(),
            // ),
          child:  RefreshIndicator(
            onRefresh: () => Future.sync(
              // 2
                  () => _topPlaylistsController.refresh(),
            ),
            // 3
            child: PagedListView.separated(
              // 4
              scrollDirection: Axis.horizontal,
              pagingController: _topPlaylistsController,
              padding: const EdgeInsets.all(16),
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, playlist, index)  {
                  // log("track is " + track.toString());
                  return PlaylistComponent(givenPlaylist: playlist);
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
