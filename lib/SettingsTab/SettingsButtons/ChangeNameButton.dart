import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsFields/RenameDisplayNameField.dart';
import 'package:fonz_music_flutter/main.dart';

class ChangeNameButton extends StatefulWidget {
  @override
  _ChangeNameButtonState createState() => _ChangeNameButtonState();
}

class _ChangeNameButtonState extends State<ChangeNameButton> {

  String userName = userAttributes.getUserDisplayName();

  refresh() {
    setState(() {
      log("setting state high");
      userName = userAttributes.getUserDisplayName();
    });
  }

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
                "$userName",
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
          RenameDisplayNameField(notifyParent: refresh)
        ],
        // style: NeumorphicStyle(
        //     shape: NeumorphicShape.flat,
        //     boxShape: NeumorphicBoxShape.rect(),
        //     color: determineColorThemeBackground(),
        //     shadowDarkColor: determineLightShadowRoundButton(),
        //     shadowLightColor: determineLightShadowRoundButton()
        // ),
        // onPressed: () async {
        //
        //   await showDialog(
        //       context: context,
        //       builder: (popupContext) {
        //         return RenameDisplayNameField(popupContext: popupContext);
        //       }
        //   );
        //   FirebaseAnalytics().logEvent(name: "userChangedName", parameters: {'string': "user"});
        //   // widget.notifyParent();
        // },


      ),
    );
  }
}
