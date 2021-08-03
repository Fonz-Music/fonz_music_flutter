import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Artist.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/SearchSuggestionsWidgets/TopArtistsWidgets/ArtistComponent.dart';

class TopArtistsView extends StatefulWidget {
  @override
  _TopArtistsViewState createState() => _TopArtistsViewState();
}

class _TopArtistsViewState extends State<TopArtistsView> {

  var tempArtists = [
    Artist("Red Hot Chili Peppers", "0L8ExT028jH3ddEcZwqJJ5", "https://i.scdn.co/image/89bc3c14aa2b4f250033ffcf5f322b2a553d9331"),
    Artist( "Kings of Leon", "2qk9voo8llSGYcZ6xrBzKx", "https://i.scdn.co/image/168a281f4a0b1c2c61acb010239ead4710a234a3"),
    Artist( "Circa Waves", "6hl5k4gLl1p3sjhHcb57t2", "https://i.scdn.co/image/4a8d60073c6ce7007ac43a4807b36f0abd381028"),
    Artist("Hippo Campus", "1btWGBz4Uu1HozTwb2Lm8A",  "https://i.scdn.co/image/ab6761610000e5eb220b2af522d5044b93fc678e"),
    Artist("COIN", "0ZxZlO7oWCSYMXhehpyMvE", "https://i.scdn.co/image/ab6761610000e5eb8a331b3acc328de052617020"),
    Artist("alt-J", "3XHO7cRUPCLOr6jwp8vsx5",  "https://i.scdn.co/image/7ac54cbec2f1b3f5f1b7f6fc23acb9d00c70fb51"),
    Artist("BENEE", "0Cp8WN4V8Tu4QJQwCN5Md4", "https://i.scdn.co/image/cf1265cb1c2c35d253cbbac9b1489bc181322ed3"),
    Artist("girl in red", "3uwAm6vQy7kWPS2bciKWx9", "https://i.scdn.co/image/ebff5a127cf8fbb20deb9bbcd02cfea64a660bef"),
    Artist("Rush", "2Hkut4rAAyrQxRdof7FVJq", "https://i.scdn.co/image/6fdfa7c623d77d5900e69eef2443340e3493a4bf")
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
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: tempArtists.length,
              itemBuilder: (BuildContext context, int index) {
                return ArtistComponent(givenArtist: tempArtists[index]);
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
