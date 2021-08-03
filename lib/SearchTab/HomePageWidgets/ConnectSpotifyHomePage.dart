import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalFunctions/ConnectSpotify.dart';
import 'package:fonz_music_flutter/MainTabs/CreateAccountPrompt.dart';
import 'package:fonz_music_flutter/MainTabs/HostTab.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/CreateAccountSettingsButton.dart';

import '../../main.dart';




class ConnectSpotifyHomePageButton extends StatefulWidget {

  ConnectSpotifyHomePageButton({Key key, @required this.notifyParent}) : super(key: key);

  final Function() notifyParent;

  @override
  _ConnectSpotifyHomePageButtonState createState() => _ConnectSpotifyHomePageButtonState();
}

class _ConnectSpotifyHomePageButtonState extends State<ConnectSpotifyHomePageButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return SizedBox(
      width: width * 0.45,
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: NeumorphicButton(
                child: Container(
                  width: 50,
                  height: 50,
                  child:
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Image(
                      image: AssetImage("assets/fonzIcons/spotifyIconGreen.png"),

                    ),
                  ),
                ),
                style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.circle(),
                    border: NeumorphicBorder(width: 2, color: SPOTIFYGREEN),
                    color: determineColorThemeBackground(),
                    shadowDarkColor: determineLightShadowRoundButton(),
                    shadowLightColor: determineLightShadowRoundButton()
                ),
                onPressed: () async {
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
                                            topLeft: const Radius.circular(25.0),
                                            topRight: const Radius.circular(25.0))),
                                    child: CreateAccountPrompt(popupContext: context, notifyParent: widget.notifyParent,),
                                  ),
                                )
                              ]
                          );
                        });
                  }
                  else {
                    await connectSpotify();
                    // link to spotify
                    // userAttributes.setConnectedToSpotify(true);
                    // connectedToSpotify = true;
                    widget.notifyParent();
                  }

                  FirebaseAnalytics().logEvent(name: "userTappedConnectToSpotifyHost", parameters: {'user': "host"});
                },

              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: new Text(
                "connect your spotify",
                style: TextStyle(
                  fontFamily: FONZFONTTWO,
                  fontSize: HEADINGSIX,
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


}
