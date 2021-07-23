import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/MainTabs/CreateAccountPrompt.dart';

import '../../main.dart';

class HostAPartyButton extends StatefulWidget {

  HostAPartyButton({Key key, @required this.notifyParent}) : super(key: key);

  final Function() notifyParent;

  @override
  _HostAPartyButtonState createState() => _HostAPartyButtonState();
}

class _HostAPartyButtonState extends State<HostAPartyButton> {

  // for platform specific code
  static const platformShare = const MethodChannel("ShareSheet");
  static const platformIgStory = const MethodChannel("ShareOnInstagram");
  var message;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery
        .of(context)
        .size;
    final width = size.width;
    final height = size.height;

    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: NeumorphicButton(
              child: Container(
                width: 100,
                height: 100,
                child:
                Container(

                  padding: const EdgeInsets.all(30),
                  child: Image(
                    image: AssetImage("assets/fonzIcons/coasterIconLilac.png"),
                  ),
                ),
              ),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  border: NeumorphicBorder(width: 2, color: LILAC),
                  color: determineColorThemeBackground()
              ),
              onPressed: () async {
                if (!hasAccount) {
                  showModalBottomSheet<dynamic>(context: context,
                      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
                   }
                  );

                }
                else {
                  currentTab = 0;
                  widget.notifyParent();
                }
                log("pressed sign out");


                // try {
                //   // var result = await platformShare.invokeMethod('launchShareSheet');
                //   // var result = await platformShare.invokeMethod('launchShareSheet', {"url": "www.fonzmusic.com"});
                //   var result = await platformIgStory.invokeMethod('shareOnInstagram', {"songTitle": "All Yours", "songArtist": "APRE", "albumArt": "https://picsum.photos/300/300"});
                //   // message = result;
                //   log("got result");
                //   log(result.toString());
                //   return message;
                // } on PlatformException catch (e) {
                // message = "Error: ${e.message}'.";
                // }

              },

            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: new Text(
              "i want to setup my coaster",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGFOUR,
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
