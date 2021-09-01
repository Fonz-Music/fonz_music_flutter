import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/main.dart';




class ManageSpotifyField extends StatefulWidget {

  ManageSpotifyField({Key key,  this.popupContext,  this.notifyParent}) : super(key: key);
  final popupContext;
  final Function() notifyParent;

  @override
  _ManageSpotifyFieldState createState() => _ManageSpotifyFieldState();
}

class _ManageSpotifyFieldState extends State<ManageSpotifyField> {


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
                'your Spotify',
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
                        getSpotifyIconLight()),
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
            'do you wanna disconnect from Spotify?',
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
                      Navigator.pop(
                          widget.popupContext);
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

                      userAttributes.setConnectedToSpotify(false);
                      userConnectedToSpotify.value = false;



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
