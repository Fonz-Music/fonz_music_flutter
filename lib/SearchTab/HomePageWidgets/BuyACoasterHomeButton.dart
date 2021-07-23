import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalFunctions/LaunchShop.dart';
import 'package:fonz_music_flutter/MainTabs/CreateAccountPrompt.dart';
import 'package:fonz_music_flutter/MainTabs/HostTab.dart';
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
    return Center(
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
                  color: determineColorThemeBackground()
              ),
              onPressed: () async {
                launchShop();
                FirebaseAnalytics().logEvent(name: "userOpenedBuyCoaster", parameters: {'string': "user", "tab": "search"});
              },

            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: new Text(
              "buy a coaster",
              style: TextStyle(
                fontFamily: FONZFONTONE,
                fontSize: HEADINGFIVE,
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
