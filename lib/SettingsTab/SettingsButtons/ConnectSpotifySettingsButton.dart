import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';

class ConnectSpotifySettingsButton extends StatefulWidget {
  @override
  _ConnectSpotifySettingsButtonState createState() => _ConnectSpotifySettingsButtonState();
}

class _ConnectSpotifySettingsButtonState extends State<ConnectSpotifySettingsButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final width = size.width;
    final height = size.height;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: NeumorphicButton(
        child: Container(
          width: width * 0.8,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Image(
                  image: AssetImage("assets/fonzIcons/spotifyIconAmber.png"),
                  height: 30,
                  width: 30,
                ),
              ),
              Text(
                "connect to Spotify",
                style: TextStyle(
                  fontFamily: FONZFONTONE,
                  fontSize: HEADINGSIX,
                  color: determineColorThemeTextInverse(),
                ),
              ),
            ],
          ),
        ),
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.rect(),
            color: determineColorThemeBackground(),
            shadowDarkColor: determineLightShadowRoundButton(),
            shadowLightColor: determineLightShadowRoundButton()
        ),
        onPressed: () {
          log("pressed sign out");
          FirebaseAnalytics().logEvent(
              name: "userOpenedManageSpotify", parameters: {'string': "user"});
        },

      ),
    );
  }
}
