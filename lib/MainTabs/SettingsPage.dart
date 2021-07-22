import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/HostTab/CoasterDashboardViews/CoasterDashboardView.dart';
import 'package:fonz_music_flutter/MainTabs/HostTab.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/BuyACoasterButton.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/ChangeNameButton.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/CreateAccountSettingsButton.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/DetermineAmountSongRequests.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/ManageSpotifyButton.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/SignOutButton.dart';

import '../main.dart';

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
          child: Column(
            children: [
              Spacer(),
              Image(image: AssetImage("assets/fonzIcons/mountainProfile.png"), width: width),
            ],
          ),
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
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
              child: new Text(
                "shop",
                style: TextStyle(
                  fontFamily: FONZFONTTWO,
                  fontSize: HEADINGFOUR,
                  color: determineColorThemeTextInverse(),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            // buy a coaster
            BuyACoasterButton(),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
              child: new Text(
                "account",
                style: TextStyle(
                  fontFamily: FONZFONTTWO,
                  fontSize: HEADINGFOUR,
                  color: determineColorThemeTextInverse(),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            DetermineWhichButtonsShown(),
            // determine # of song queues
            // DetermineAmountSongRequests()
        ]
        ),
      ]
    );
  }
  Widget DetermineWhichButtonsShown() {
    if (hasConnectedCoasters && connectedToSpotify) {
      return Column(
        children: [

          // change name
          ChangeNameButton(),
          // sign out
          SignOutButton(),
          // manage spotify
          ManageSpotifyButton(),
        ],
      );
    }
    else if (hasConnectedCoasters) {
      return Column(
        children: [

          // change name
          ChangeNameButton(),
          // sign out
          SignOutButton(),
        ],
      );
    }
    else {
      return CreateAccountSettingsButton();
    }
  }
}
