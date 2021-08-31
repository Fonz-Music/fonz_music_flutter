import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/scanForCoasterDetails.dart';

import '../HomeEncodePage.dart';

class EncodeATagButton extends StatefulWidget {

  EncodeATagButton({Key key, @required this.notifyParent}) : super(key: key);

  final Function() notifyParent;

  @override
  _EncodeATagButtonState createState() => _EncodeATagButtonState();
}

class _EncodeATagButtonState extends State<EncodeATagButton> {
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
                encodeTagResponse = "READING_TAG";
                // widget.notifyParent();

                var tagUidResp = await scanForTagUid();
                encodeTagResponse = tagUidResp[0];
                tagUid = tagUidResp[1];

                launchedNfcToJoinParty = true;
                widget.notifyParent();
              },

            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: new Text(
              "encode a tag",
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
