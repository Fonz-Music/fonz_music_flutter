import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/MainTabs/CreateAccountPrompt.dart';
import 'package:fonz_music_flutter/MainTabs/HostTab.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/CreateAccountSettingsButton.dart';

import '../../main.dart';




class ConnectSpotifyButton extends StatefulWidget {

  ConnectSpotifyButton({Key key, @required this.notifyParent}) : super(key: key);

  final Function() notifyParent;

  @override
  _ConnectSpotifyButtonState createState() => _ConnectSpotifyButtonState();
}

class _ConnectSpotifyButtonState extends State<ConnectSpotifyButton> {
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
                    image: AssetImage("assets/fonzIcons/spotifyIconGreen.png"),

                  ),
                ),
              ),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  border: NeumorphicBorder(width: 2, color: SPOTIFYGREEN),
                  color: determineColorThemeBackground()
              ),
              onPressed: () async {
                if (!hasAccount) {
                    showModalBottomSheet(context: context, builder: (BuildContext context) {
                      return CreateAccountPrompt();
                    });
                }
                else {
                  // link to spotify
                  connectedToSpotify = true;
                  widget.notifyParent();
                }

                FirebaseAnalytics().logEvent(name: "userTappedConnectToSpotifyHost", parameters: {'user': "host"});
              },

            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: new Text(
              "connect your spotify",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGFOUR,
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
