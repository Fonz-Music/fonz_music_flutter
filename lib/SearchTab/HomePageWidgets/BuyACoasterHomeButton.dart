import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/ApiFunctions/ApiConstants.dart';
import 'package:fonz_music_flutter/ApiFunctions/AuthMethods.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestGetCoasterApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifyEndpoints/SpotifySignInApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifyEndpoints/SpotifySuggestionsApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalFunctions/LaunchShop.dart';
import 'package:fonz_music_flutter/MainTabs/CreateAccountPrompt.dart';
import 'package:fonz_music_flutter/MainTabs/HostTab.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/scanForCoasterDetails.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsButtons/CreateAccountSettingsButton.dart';

import '../../main.dart';




class BuyACoasterHomeButton extends StatefulWidget {

  // BuyACoasterHomeButton({Key key, @required this.notifyParent}) : super(key: key);



  @override
  _BuyACoasterHomeButtonState createState() => _BuyACoasterHomeButtonState();
}

class _BuyACoasterHomeButtonState extends State<BuyACoasterHomeButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return SizedBox(
      width: width * .45,
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
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: LILAC,
                    )
                    // child: Image(
                    //   image: AssetImage("assets/fonzIcons/spotifyIconGreen.png"),
                    //
                    // ),
                  ),
                ),
                style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.circle(),
                    border: NeumorphicBorder(width: 2, color: LILAC),
                    color: determineColorThemeBackground(),
                    shadowDarkColor: determineLightShadowRoundButton(),
                    shadowLightColor: determineLightShadowRoundButton()
                ),
                onPressed: () async {
                  var tempSessionId = "60224ecc-a00f-437a-8743-4909a8eb7a6c";
                  SpotifySuggestionsApi.getGuestTopSongs(tempSessionId);

                  // userAttributes.setConnectedToSpotify(false);
                  // launchShop();
                  FirebaseAnalytics().logEvent(name: "userOpenedBuyCoaster", parameters: {'string': "user", "tab": "search"});
                },

              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: new Text(
                "buy a coaster",
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
