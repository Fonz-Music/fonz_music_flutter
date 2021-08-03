import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/MainTabs/CreateAccountPrompt.dart';




class CreateAccountSettingsButton extends StatefulWidget {
  @override
  _CreateAccountSettingsButtonState createState() => _CreateAccountSettingsButtonState();
}

class _CreateAccountSettingsButtonState extends State<CreateAccountSettingsButton> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
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
                  image: AssetImage("assets/fonzIcons/signOutIcon.png"),
                  height: 30,
                  width: 30,
                ),
              ),
              Text(
                "create account",
                style: TextStyle(
                  fontFamily: FONZFONTONE,
                  fontSize: HEADINGFIVE,
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
                      child: CreateAccountPrompt(),
                    ),
                  )
                ]
            );
          });
          // FirebaseAnalytics().logEvent(name: "userTappedCreateAccountSettings", parameters: {'string': "user"});
        },

      ),
    );
  }
}
