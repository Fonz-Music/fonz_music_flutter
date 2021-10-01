import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsFields/ManageSpotifyField.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsFields/SignOutSpotifyField.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsFields/TroubleShootSpotifyField.dart';
import 'package:fonz_music_flutter/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

// String spotifyId  = "spotify account";

class ManageSpotifyButton extends StatefulWidget {

  ManageSpotifyButton({Key key,  this.notifyParent}) : super(key: key);
  Function notifyParent;

  @override
  _ManageSpotifyButtonState createState() => _ManageSpotifyButtonState();
}

class _ManageSpotifyButtonState extends State<ManageSpotifyButton> {



  // @override
  // void initState() {
  //   super.initState();
  //   // get sessionId from local storage
  //   SharedPreferences.getInstance().then((prefs) {
  //     var spotifyFromStorage = prefs.getString("spotifyDisplayName");
  //     if (spotifyFromStorage != null && spotifyFromStorage != "") {
  //
  //       spotifyId = spotifyFromStorage;
  //     }
  //   } );
  //
  //
  // }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      width: width * 0.9,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ]
      ),
      child: ExpansionTile(
        backgroundColor: determineColorThemeText(),
        collapsedBackgroundColor: determineColorThemeText(),
        title: Container(
        // child: Container(
          width: width * 0.8,
          color: determineColorThemeText(),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Image(
                  image: AssetImage("assets/fonzIcons/spotifyIconAmber.png"),
                  height: 30,
                  width: 30
                ),
              ),
              Text(
                userAttributes.getSpotifyId(),
                style: TextStyle(
                  fontFamily: FONZFONTONE,
                  fontSize: HEADINGSIX,
                  color: determineColorThemeTextInverse(),
                ),
              ),
            ],
          ),
        ),
        children: [
          SignOutSpotifyField(notifyParent: widget.notifyParent,),
          TroubleShootSpotifyField()
        ],
      ),
    );
  }
}
