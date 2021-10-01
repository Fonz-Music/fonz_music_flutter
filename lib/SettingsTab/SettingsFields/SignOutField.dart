import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/main.dart';




class SignOutField extends StatefulWidget {

  SignOutField({Key key,  this.notifyParent}) : super(key: key);
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

    return
        Column(
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
                      await userAttributes.deleteAttributesAfterSignOut();

                      // Create storage
                      final storage = new FlutterSecureStorage();
                      // delete accessToken
                      await storage.delete(key: "accessToken");
                      // delete refreshToken
                      await storage.delete(key: "refreshToken");

                      widget.notifyParent();
                    },
                  ),
                ),

              ],

    );
  }
}
