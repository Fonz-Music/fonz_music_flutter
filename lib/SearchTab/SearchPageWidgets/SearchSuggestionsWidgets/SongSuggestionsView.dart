import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalSessionVariables.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/SearchSuggestionsWidgets/ConnectSpotifySearchPage.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/SearchSuggestionsWidgets/TopArtistsWidgets/TopArtistsFutureBuilder.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/SearchSuggestionsWidgets/TopArtistsWidgets/TopArtistsView.dart';

import '../../../main.dart';
import 'TopPlaylistsWidgets/TopPlaylistsFutureBuilder.dart';
import 'TopPlaylistsWidgets/TopPlaylistsView.dart';
import 'TopSongsWidgets/TopSongsFutureBuilder.dart';
import 'TopSongsWidgets/TopSongsView.dart';

class SongSuggestionsView extends StatefulWidget {

  SongSuggestionsView({Key key, @required this.notifyParent}) : super(key: key);

  final Function() notifyParent;

  @override
  _SongSuggestionsViewState createState() => _SongSuggestionsViewState();
}

class _SongSuggestionsViewState extends State<SongSuggestionsView> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery
        .of(context)
        .size;
    final width = size.width;
    final height = size.height;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Stack(

          children: [
            Container(
              height: determineSongSugsHeight(),
              decoration: BoxDecoration(
                  color: determineColorThemeBackground(),
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: ValueNotifier(userConnectedToSpotify.value),
              builder: (context, value, child) {
                return Column(
                  children: [
                    DetermineIfSpotifyButtonShown(),
                    // TopSongsFutureBuilder(),
                    TopSongsView(),
                    // TopArtistsFutureBuilder(),
                    TopArtistsView(),
                    // TopPlaylistsFutureBuilder(),
                    TopPlaylistsView()
                  ],
                );
              }
            )

          ]
      ),
    );
  }

  Widget DetermineIfSpotifyButtonShown() {

    if (!userAttributes.getConnectedToSpotify()) {
      return ConnectSpotifySearchPageButton(notifyParent: widget.notifyParent);
    }
    else return Container(height: 0);
  }

  double determineSongSugsHeight() {

    if (!userAttributes.getConnectedToSpotify()) {
      return 790.0;
    }
    else return 740.0;
  }

}
