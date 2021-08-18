import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Playlist.dart';

import 'PlaylistComponent.dart';

class TopPlaylistsView extends StatefulWidget {

  TopPlaylistsView({Key key, this.playlists}) : super(key: key);
  List<Playlist> playlists;

  @override
  _TopPlaylistsViewState createState() => _TopPlaylistsViewState();
}

class _TopPlaylistsViewState extends State<TopPlaylistsView> {



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
            child: ListView.separated(

              scrollDirection: Axis.horizontal,
              itemCount: widget.playlists.length,
              itemBuilder: (BuildContext context, int index) {
                return PlaylistComponent(givenPlaylist: widget.playlists[index]);
              },
              separatorBuilder: (BuildContext context,
                  int index) => const Divider(),
            ),
          ),
        )
      ],
    );
  }
}
