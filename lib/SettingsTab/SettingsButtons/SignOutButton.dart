import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/SettingsTab/SettingsFields/SignOutField.dart';




class SignOutButton extends StatefulWidget {

  SignOutButton({Key key,  this.notifyParent}) : super(key: key);
  Function notifyParent;

  @override
  _SignOutButtonState createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
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
                  image: AssetImage("assets/fonzIcons/signOutIcon.png"),
                  height: 30,
                  width: 30,
                ),
              ),
              Text(
                "sign out",
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
          SignOutField(notifyParent: widget.notifyParent,)
        ],
      ),
    );
  }
}
