import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Stack(
      children: [
         Container(
          color: determineColorThemeBackground(),
         ),
        Opacity(
          child: Image(image: AssetImage("assets/fonzIcons/mountainProfile.png")),
          opacity: 0.4,
        ),
        Column(
          children: [

           Container(
             width: width,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: new Text(
                  "settings",
                  style: TextStyle(
                    fontFamily: FONZFONTTWO,
                    fontSize: HEADINGTHREE,
                    color: determineColorThemeTextInverse(),
                  ),
                  textAlign: TextAlign.left,
                ),
              )
          ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: NeumorphicButton(
                child: Container(
                  width: width * 0.8,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Image(
                          image: AssetImage("assets/darkGreyIcons/coasterIconDarkGrey.png"),
                          height: 30,
                          width: 30,
                        ),
                      ),
                       Text(
                        "change your name",
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
                  color: determineColorThemeBackground()
                ),
                onPressed: () {
                  log("pressed sign out");
                },

              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: NeumorphicButton(
                child: Container(
                  width: width * 0.8,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Image(
                          image: AssetImage("assets/darkGreyIcons/coasterIconDarkGrey.png"),
                          height: 30,
                          width: 30,
                        ),
                      ),
                      Text(
                        "buy a coaster",
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
                    color: determineColorThemeBackground()
                ),
                onPressed: () {
                  log("pressed sign out");
                },

              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: NeumorphicButton(
                child: Container(
                  width: width * 0.8,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Image(
                          image: AssetImage("assets/darkGreyIcons/spotifyIconDarkGrey.png"),
                          height: 30,
                          width: 30,
                        ),
                      ),
                      Text(
                        "spotify account",
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
                    color: determineColorThemeBackground()
                ),
                onPressed: () {
                  log("pressed sign out");
                },

              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: NeumorphicButton(
                child: Container(
                  width: width * 0.8,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Image(
                          image: AssetImage("assets/darkGreyIcons/disableIconDarkGrey.png"),
                          height: 30,
                          width: 30,
                        ),
                      ),
                      Text(
                        "sign out",
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
                    color: determineColorThemeBackground()
                ),
                onPressed: () {
                  log("pressed sign out");
                },

              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            //   child: Neumorphic(
            //     child: Container(
            //       width: width * 0.9,
            //       height: 150,
            //       child: Column(
            //         children: [
            //           Padding(
            //             padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            //             child: new Text(
            //               "how many songs can your guests make?",
            //               style: TextStyle(
            //                 fontFamily: FONZFONTONE,
            //                 fontSize: HEADINGFIVE,
            //                 color: determineColorThemeText(),
            //               ),
            //               textAlign: TextAlign.left,
            //             ),
            //           ),
            //           Row(
            //             children: [
            //               Padding(
            //                 padding: EdgeInsets.fromLTRB(width * 0.05, 10, 5, 10),
            //                 child: NeumorphicButton(
            //                   child: Container(
            //                     width: width * 0.15,
            //                     child: Column(
            //                       children: [
            //
            //                         Text(
            //                           "a few",
            //                           style: TextStyle(
            //                             fontFamily: FONZFONTONE,
            //                             fontSize: 14,
            //                             color: AMBER,
            //                           ),
            //                         ),
            //                         Padding(
            //                           padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            //                           child: Image(
            //                             image: AssetImage("assets/darkGreyIcons/disableIconDarkGrey.png"),
            //                             height: 20,
            //                             width: 20,
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                   style: NeumorphicStyle(
            //                       shape: NeumorphicShape.flat,
            //                       boxShape: NeumorphicBoxShape.rect(),
            //                       color: determineColorThemeBackground()
            //                   ),
            //                   onPressed: () {
            //                     log("pressed sign out");
            //                   },
            //
            //                 ),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            //                 child: NeumorphicButton(
            //                   child: Container(
            //                     width: width * 0.15,
            //                     child: Column(
            //                       children: [
            //
            //                         Text(
            //                           "a lot",
            //                           style: TextStyle(
            //                             fontFamily: FONZFONTONE,
            //                             fontSize: 14,
            //                             color: AMBER,
            //                           ),
            //                         ),
            //                         Padding(
            //                           padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            //                           child: Image(
            //                             image: AssetImage("assets/darkGreyIcons/disableIconDarkGrey.png"),
            //                             height: 20,
            //                             width: 20,
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                   style: NeumorphicStyle(
            //                       shape: NeumorphicShape.flat,
            //                       boxShape: NeumorphicBoxShape.rect(),
            //                       color: determineColorThemeBackground()
            //                   ),
            //                   onPressed: () {
            //                     log("pressed sign out");
            //                   },
            //
            //                 ),
            //               ),
            //               Padding(
            //                 padding:  EdgeInsets.fromLTRB(5, 10, width * 0.05, 10),
            //                 child: NeumorphicButton(
            //                   child: Container(
            //                     width: width * 0.175,
            //                     child: Column(
            //                       children: [
            //
            //                         Text(
            //                           "unlimited",
            //                           style: TextStyle(
            //                             fontFamily: FONZFONTONE,
            //                             fontSize: 14,
            //                             color: AMBER,
            //                           ),
            //                         ),
            //                         Padding(
            //                           padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            //                           child: Image(
            //                             image: AssetImage("assets/darkGreyIcons/disableIconDarkGrey.png"),
            //                             height: 20,
            //                             width: 20,
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                   style: NeumorphicStyle(
            //                       shape: NeumorphicShape.flat,
            //                       boxShape: NeumorphicBoxShape.rect(),
            //                       color: determineColorThemeBackground()
            //                   ),
            //                   onPressed: () {
            //                     log("pressed sign out");
            //                   },
            //
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //     style: NeumorphicStyle(
            //         shape: NeumorphicShape.flat,
            //         boxShape: NeumorphicBoxShape.rect(),
            //         color: determineColorThemeBackground()
            //     ),
            //     // onPressed: () {
            //     //   log("pressed sign out");
            //     // },
            //
            //   ),
            // ),


        ]
        ),
      ]
    );
  }
}
