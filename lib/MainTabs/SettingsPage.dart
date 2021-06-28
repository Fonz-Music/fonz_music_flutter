import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/BuyACoasterButton.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/ChangeNameButton.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/DetermineAmountSongRequests.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/ManageSpotifyButton.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/SignOutButton.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Stack(
      children: [
         Container(
          color: determineColorThemeBackground(),
         ),
        Opacity(
          child: Image(image: AssetImage("assets/fonzIcons/mountainProfile.png")),
          opacity: 0.4,
        ),
        Column(
          children: [


           Container(
             width: width,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: new Text(
                  "settings",
                  style: TextStyle(
                    fontFamily: FONZFONTTWO,
                    fontSize: HEADINGTHREE,
                    color: determineColorThemeTextInverse(),
                  ),
                  textAlign: TextAlign.left,
                ),
              )
          ),
            // change name
            ChangeNameButton(),
            // buy a coaster
            BuyACoasterButton(),
            // manage spotify
            ManageSpotifyButton(),
            // sign out
            SignOutButton(),
            // determine # of song queues
            // DetermineAmountSongRequests()
        ]
        ),
      ]
    );
  }
}
