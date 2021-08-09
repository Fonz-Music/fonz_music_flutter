import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';

class CoasterHasDifferentHost extends StatefulWidget {

  String connectedCoasterName;
  String coasterHostName;

  CoasterHasDifferentHost({Key key, @required this.connectedCoasterName, this.coasterHostName}) : super(key: key);



  @override
  _CoasterHasDifferentHostState createState() => _CoasterHasDifferentHostState();
}

class _CoasterHasDifferentHostState extends State<CoasterHasDifferentHost> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: NeumorphicButton(
              child: Container(
                width: 100,
                height: 100,
                child:
                Container(
                  padding: const EdgeInsets.all(30),
                  child: Image(
                    image: AssetImage("assets/fonzIcons/coasterIconLilac.png"),
                  ),
                ),
              ),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  border: NeumorphicBorder(width: 2, color: LILAC),
                  color: determineColorThemeBackground()
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: new Text(
              "this coaster belongs to",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGFOUR,
                color: determineColorThemeTextInverse(),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: new Text(
              "${widget.coasterHostName}",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGTHREE,
                color: LILAC,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: new Text(
              "& is named",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGFOUR,
                color: determineColorThemeTextInverse(),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: new Text(
              "${widget.connectedCoasterName}",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGTHREE,
                color: LILAC,
              ),
              textAlign: TextAlign.center,
            ),
          ),

        ],
      ),
    );
  }
}
