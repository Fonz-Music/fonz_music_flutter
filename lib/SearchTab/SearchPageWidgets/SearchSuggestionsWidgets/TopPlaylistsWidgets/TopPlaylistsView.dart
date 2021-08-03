import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Playlist.dart';

import 'PlaylistComponent.dart';

class TopPlaylistsView extends StatefulWidget {
  @override
  _TopPlaylistsViewState createState() => _TopPlaylistsViewState();
}

class _TopPlaylistsViewState extends State<TopPlaylistsView> {

  var tempPlaylists =
      [
  Playlist("This Is Rush", "https://i.scdn.co/image/ab67706f0000000336834b90af842ac737f7dac3",  "37i9dQZF1DX9E92APFiTvV", 50),
  Playlist("memoryLane",  "https://i.scdn.co/image/ab67706c0000bebbbbb8672f1afbe3add6554550",  "3sRM90oyy8Zul8iF3Cg3RF", 21),
  Playlist("beautifulEscape",   "https://i.scdn.co/image/ab67706c0000bebb12bc8c494507c2f6550b919b", "4d2ObNuTa7AIMJY8TGvLDB", 31),
  Playlist("manifest destiny", "https://i.scdn.co/image/ab67706c0000bebb802a02183d45115fc2639cb6",  "4TOUWjjIiwBNXj82cLnltq", 43),
  Playlist("malibuNinetyTwo", "https://i.scdn.co/image/ab67706c0000bebb0e65fceaffd297b0f3f14756",  "6rqm7IuR0DRbktih6FV9jm", 83)

  ];

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
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: tempPlaylists.length,
            itemBuilder: (BuildContext context, int index) {
              return PlaylistComponent(givenPlaylist: tempPlaylists[index]);
            },
            separatorBuilder: (BuildContext context,
                int index) => const Divider(),
          ),
        )
      ],
    );
  }
}
