import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/main.dart';




class SignOutField extends StatefulWidget {

  SignOutField({Key key,  this.popupContext,  this.notifyParent}) : super(key: key);
  final popupContext;
  final Function() notifyParent;

  @override
  _SignOutFieldState createState() => _SignOutFieldState();
}

class _SignOutFieldState extends State<SignOutField> {


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery
        .of(context)
        .size;
    final width = size.width;
    final height = size.height;

    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      // contentPadding: EdgeInsets.all(0),

      insetPadding: EdgeInsets.fromLTRB(width * 0.07, 0, width * 0.07, 0),
      // insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius
              .circular(CORNERRADIUSBUTTON)
      ),
      backgroundColor: determineColorThemeBackground(),
      title:
      Container(
        width: width * 0.8,
        color: AMBER,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text(
                'sign out',
                style: TextStyle(
                  fontFamily: FONZFONTONE,
                  fontSize: HEADINGFIVE,
                  color: Colors.white,
                ),
                textAlign: TextAlign
                    .center,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child:  Center(
                child: Container(
                  height: 25,
                  width: 30,
                  child: Image(
                    image: AssetImage(
                        getCoasterIconLight()),
                  ),
                ),
              ),
            )

          ],
        ),
      ),

      children: [
        Container(

          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Text(
            'are you sure you wanna sign out?',
            style: TextStyle(
              fontFamily: FONZFONTONE,
              fontSize: HEADINGFIVE,
              color: determineColorThemeTextInverse(),
            ),
            textAlign: TextAlign
                .center,
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    child: Icon(
                      Icons.clear,
                      size: 18,
                      color: Colors.white,
                    ),
                    color: AMBER,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
                    ),
                    onPressed: () {

                      widget.notifyParent();
                      Navigator.pop(widget.popupContext);
                    },
                  ),
                ),

                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    child: Icon(
                      Icons.check,
                      size: 18,
                      color: Colors.white,
                    ),
                    color: AMBER,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
                    ),
                    onPressed: () async{
                      log("signing out");
                      await userAttributes.setHasAccount(false);
                      await userAttributes.setHasConnectedCoasters(false);
                      await userAttributes.setConnectedToSpotify(false);

                      // Create storage
                      final storage = new FlutterSecureStorage();
                      // delete accessToken
                      await storage.delete(key: "accessToken");
                      // delete refreshToken
                      await storage.delete(key: "refreshToken");

                      widget.notifyParent();
                      Navigator.pop(widget.popupContext);
                    },
                  ),
                ),
                Spacer()
              ],
            ),
          ],
        )

      ],
    );
  }
}
