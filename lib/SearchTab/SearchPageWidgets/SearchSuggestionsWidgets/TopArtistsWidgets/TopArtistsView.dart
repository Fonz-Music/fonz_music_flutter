import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';

class TopArtistsView extends StatefulWidget {
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
              padding: EdgeInsets.fromLTRB(20, 30, 0, 10),
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
          height: 175,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(3, 3), // changes position of shadow
              ),
            ],
            color: determineColorThemeText(),
            borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [

            ],
          ),
        )
      ],
    );
  }
}
