import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsFields/RenameDisplayNameField.dart';

class ChangeNameButton extends StatefulWidget {
  @override
  _ChangeNameButtonState createState() => _ChangeNameButtonState();
}

class _ChangeNameButtonState extends State<ChangeNameButton> {
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
                  image: AssetImage("assets/fonzIcons/changeNameIcon.png"),
                  height: 30,
                  width: 30,
                ),
              ),
              Text(
                "change your name",
                style: TextStyle(
                  fontFamily: FONZFONTONE,
                  fontSize: HEADINGSIX,
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
        onPressed: () async {

          await showDialog(
              context: context,
              builder: (popupContext) {
                return RenameDisplayNameField(popupContext: popupContext);
              }
          );
          FirebaseAnalytics().logEvent(name: "userChangedName", parameters: {'string': "user"});
          // widget.notifyParent();
        },


      ),
    );
  }
}
