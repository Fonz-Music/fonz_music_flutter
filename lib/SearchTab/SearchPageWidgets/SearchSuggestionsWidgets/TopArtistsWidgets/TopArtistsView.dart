import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Artist.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/SearchSuggestionsWidgets/TopArtistsWidgets/ArtistComponent.dart';

class TopArtistsView extends StatefulWidget {

  TopArtistsView({Key key, this.artists}) : super(key: key);
  List<Artist> artists;

  @override
  _TopArtistsViewState createState() => _TopArtistsViewState();
}

class _TopArtistsViewState extends State<TopArtistsView> {



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
              itemCount: widget.artists.length,
              itemBuilder: (BuildContext context, int index) {
                return ArtistComponent(givenArtist: widget.artists[index]);
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
