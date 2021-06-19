import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';

class HostAPartyButton extends StatefulWidget {
  @override
  _HostAPartyButtonState createState() => _HostAPartyButtonState();
}

class _HostAPartyButtonState extends State<HostAPartyButton> {
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
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
    );
  }
}
