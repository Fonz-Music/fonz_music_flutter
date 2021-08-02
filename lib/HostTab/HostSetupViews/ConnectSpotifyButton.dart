import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalFunctions/ConnectSpotify.dart';
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

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Opacity(
      opacity: determineSpotifyOpacity(),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: NeumorphicButton(
                child: Container(
                  width: determineSpotifyCircleSize(),
                  height: determineSpotifyCircleSize(),
                  child:
                  Container(
                    padding: EdgeInsets.all(determineeSpotifyInternalPaddingSize()),
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
                  if (!userAttributes.getConnectedToSpotify()) {
                    if (!userAttributes.getHasAccount()) {
                      showModalBottomSheet<dynamic>(context: context,
                          isScrollControlled: true,
                          builder: (BuildContext bc) {
                            return Wrap(
                                children: <Widget>[
                                  Container(
                                    height: height * 0.95,
                                    child: Container(
                                      decoration: new BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: new BorderRadius.only(
                                              topLeft: const Radius.circular(
                                                  25.0),
                                              topRight: const Radius.circular(
                                                  25.0))),
                                      child: CreateAccountPrompt(popupContext: context),
                                    ),
                                  )
                                ]
                            );
                          });
                    }
                    else {
                      // link to spotify
                      await connectSpotify();
                      widget.notifyParent();
                    }
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
                  fontSize: determineSpotifyTextSize(),
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

  determineSpotifyCircleSize() {
    if (userAttributes.getConnectedToSpotify()) return 50.0;
    else return 150.0;
  }
  determineeSpotifyInternalPaddingSize() {
    if (userAttributes.getConnectedToSpotify()) return 10.0;
    else return 40.0;
  }
  determineSpotifyTextSize() {
    if (userAttributes.getConnectedToSpotify()) return HEADINGFIVE;
    else return HEADINGFOUR;
  }
  determineSpotifyOpacity() {
    if (userAttributes.getConnectedToSpotify()) return 0.4;
    else return 1.0;
  }

}
