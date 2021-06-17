import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEndConstants.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
            child: new Text(
              "search",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGTHREE,
                color: determineColorThemeText(),
              ),
              textAlign: TextAlign.center,
            ),
          )
      ),
    );
  }
}
