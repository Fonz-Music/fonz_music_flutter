import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/HostTab/CoasterDashboardViews/CoasterDashboardView.dart';
import 'package:fonz_music_flutter/MainTabs/HostTab.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/BuyACoasterButton.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/ChangeNameButton.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/ConnectSpotifySettingsButton.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/CreateAccountSettingsButton.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/DetermineAmountSongRequests.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/ManageSpotifyButton.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/SignOutButton.dart';

import '../main.dart';

class SettingsPage extends StatefulWidget {

  SettingsPage({Key key,  this.notifyParent}) : super(key: key);
  Function notifyParent;
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
              Image(image: AssetImage("assets/fonzIcons/mountainProfileLarger.png"), width: width,),
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
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 30, 0, 10),
                  child: new Text(
                    "shop",
                    style: TextStyle(
                      fontFamily: FONZFONTTWO,
                      fontSize: HEADINGFIVE,
                      color: determineColorThemeTextInverse(),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Spacer()
              ],
            ),
            // buy a coaster
            BuyACoasterButton(),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 30, 0, 10),
                  child: new Text(
                    "account",
                    style: TextStyle(
                      fontFamily: FONZFONTTWO,
                      fontSize: HEADINGFIVE,
                      color: determineColorThemeTextInverse(),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Spacer()
              ],
            ),
            DetermineWhichButtonsShown(widget.notifyParent),
            // determine # of song queues
            // DetermineAmountSongRequests()
        ]
        ),
      ]
    );
  }
  Widget DetermineWhichButtonsShown(notifyParent) {
    if (hasAccount && connectedToSpotify) {
      return Column(
        children: [

          // change name
          ChangeNameButton(),
          // manage spotify
          ManageSpotifyButton(notifyParent: notifyParent),
          // sign out
          SignOutButton(notifyParent: notifyParent),

        ],
      );
    }
    else if (hasAccount) {
      return Column(
        children: [

          // change name
          ChangeNameButton(),
          // connect to spotify
          ConnectSpotifySettingsButton(),
          // sign out
          SignOutButton(notifyParent: notifyParent),
        ],
      );
    }
    else {
      return CreateAccountSettingsButton();
    }
  }
}
