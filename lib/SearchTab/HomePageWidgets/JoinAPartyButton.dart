import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/HostTab/HostSetup.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/scanForCoasterDetails.dart';

import '../HomePageDecision.dart';

class JoinAPartyButton extends StatefulWidget {

  JoinAPartyButton({Key key, @required this.notifyParent}) : super(key: key);

  final Function() notifyParent;

  @override
  _JoinAPartyButtonState createState() => _JoinAPartyButtonState();
}

class _JoinAPartyButtonState extends State<JoinAPartyButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: NeumorphicButton(
              child: Container(
                width: 200,
                height: 200,
                child:
                Container(
                  padding: const EdgeInsets.all(70),
                  child: Image(
                    image: AssetImage("assets/fonzIcons/plusIconAmber.png"),

                  ),
                ),
              ),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  border: NeumorphicBorder(width: 2, color: AMBER),
                  color: determineColorThemeBackground(),
                  shadowDarkColor: determineLightShadowRoundButton(),
                  shadowLightColor: determineLightShadowRoundButton()
              ),
              onPressed: () async {
                pressedNfcButtonToJoinPartu = true;
                widget.notifyParent();

                hostCoasterDetails = await scanForCoasterDetails();
                launchedNfcToJoinParty = true;
                widget.notifyParent();
              },

            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: new Text(
              "queue a song",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGTHREE,
                color: determineColorThemeTextInverse(),
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }


}
