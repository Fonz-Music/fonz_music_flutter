import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestGetCoasterApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/HostApi/CoasterManagementApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/ExceptionHandling.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';

import 'package:fonz_music_flutter/NfcFunctions/HostNfcFunctions.dart';


import '../../main.dart';
import '../HostFunctions.dart';
import '../HostSetup.dart';



class ConnectYourFirstCoasterButton extends StatefulWidget {

  ConnectYourFirstCoasterButton({Key key, @required this.notifyParent}) : super(key: key);

  final Function() notifyParent;

  @override
  _ConnectYourFirstCoasterButtonState createState() => _ConnectYourFirstCoasterButtonState();
}

class _ConnectYourFirstCoasterButtonState extends State<ConnectYourFirstCoasterButton> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: determineFirstCoasterOpacity(),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: NeumorphicButton(
                child: Container(
                  width: determineFirstCoasterCircleSize(),
                  height: determineFirstCoasterCircleSize(),
                  child:
                  Container(
                    padding: EdgeInsets.all(determineFirstCoasterInternalPaddingSize()),
                    child: Image(
                      image: AssetImage("assets/lightGreyIcons/coasterIconLightGrey.png"),

                    ),
                  ),
                ),
                style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.circle(),
                    border: NeumorphicBorder(width: 2, color: Colors.white),
                    color: LILAC,
                    shadowDarkColor: determineLightShadowRoundButton(),
                    shadowLightColor: determineLightShadowRoundButton()
                ),
                onPressed: () async {
                  if (userAttributes.getConnectedToSpotify()) {
                    pressedToConnectFirstCoaster = true;
                    widget.notifyParent();

                    firstConnectedCoasterDetails = await addCoaster();

                    // firstConnectedCoasterDetails.statusCode = 204;
                    launchedNfcForFirstCoaster = true;
                    pressedToConnectFirstCoaster = false;
                    widget.notifyParent();
                  }
                },

              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: new Text(
                "connect your first coaster",
                style: TextStyle(
                  fontFamily: FONZFONTTWO,
                  fontSize: determineFirstCoasterTextSize(),
                  color: determineColorThemeTextInverse(),
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }


  determineFirstCoasterCircleSize() {
    if (!userAttributes.getConnectedToSpotify()) return 50.0;
    else return 150.0;
  }
  determineFirstCoasterInternalPaddingSize() {
    if (!userAttributes.getConnectedToSpotify()) return 10.0;
    else return 40.0;
  }
  determineFirstCoasterTextSize() {
    if (!userAttributes.getConnectedToSpotify()) return HEADINGFIVE;
    else return HEADINGFOUR;
  }
  determineFirstCoasterOpacity() {
    if (!userAttributes.getConnectedToSpotify()) return 0.4;
    else return 1.0;
  }

}
