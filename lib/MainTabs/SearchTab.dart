import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEndConstants.dart';

class SearchTab extends StatefulWidget {

  SearchTab({Key key, this.currentTab, this.notifyParent}) : super(key: key);
  int currentTab;
  final Function() notifyParent;

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      child:  Column(
        children: [
          Container(
            width: width,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: new Text(
                  "search",
                  style: TextStyle(
                    fontFamily: FONZFONTTWO,
                    fontSize: HEADINGTHREE,
                    color: determineColorThemeText(),
                  ),
                  textAlign: TextAlign.left,
                ),
              )
          ),
          Spacer(),
          Center(
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
                            image: AssetImage("assets/darkGreyIcons/coasterIconDarkGrey.png"),
                          ),
                        ),
                      ),
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.circle(),
                        border: NeumorphicBorder(width: 2, color: AMBER),
                        color: determineColorThemeBackground()
                    ),
                    onPressed: () {
                      log("pressed sign out");
                    },

                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: new Text(
                    "i want to setup my coaster",
                    style: TextStyle(
                      fontFamily: FONZFONTTWO,
                      fontSize: HEADINGFOUR,
                      color: determineColorThemeText(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Center(
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
                          image: AssetImage("assets/darkGreyIcons/queueIconDarkGrey.png"),

                        ),
                      ),
                    ),
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.circle(),
                        border: NeumorphicBorder(width: 2, color: LILAC),
                        color: determineColorThemeBackground()
                    ),
                    onPressed: () {
                      widget.currentTab = 0;
                      widget.notifyParent();
                      log("pressed sign out");
                    },

                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: new Text(
                    "i want to queue a song",
                    style: TextStyle(
                      fontFamily: FONZFONTTWO,
                      fontSize: HEADINGFOUR,
                      color: determineColorThemeText(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}
