import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalFunctions/ConnectSpotify.dart';
import 'package:fonz_music_flutter/HostTab/CoasterDashboardViews/CoasterDashboardFields/RenameCoasterField.dart';
import 'package:fonz_music_flutter/HostTab/HostFunctions.dart';
import 'package:fonz_music_flutter/MainTabs/CreateAccountPrompt.dart';
import 'package:fonz_music_flutter/main.dart';

import '../../HomePageDecision.dart';

class CoasterHasNoHost extends StatefulWidget {


  CoasterHasNoHost({Key key, @required this.tabSelected, this.notifyParent, this.coasterUid}) : super(key: key);
  var tabSelected;
  Function notifyParent;
  var coasterUid;

  @override
  _CoasterHasNoHostState createState() => _CoasterHasNoHostState();
}

class _CoasterHasNoHostState extends State<CoasterHasNoHost> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
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
                  child: Icon(
                    Icons.remove,
                    color: LILAC,
                    size: 30

                  ),
                  // /// ),
                ),
              ),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  border: NeumorphicBorder(width: 2, color: LILAC),
                  color: determineColorThemeBackground(),
                  shadowDarkColor: determineLightShadowRoundButton(),
                  shadowLightColor: determineLightShadowRoundButton()
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: new Text(
              "this coaster doesn't have a host!",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGFOUR,
                color: LILAC,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: new Text(
              "would you like to connect?",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGFOUR,
                color: LILAC,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child:
            Center(
              child: FlatButton(
                onPressed: () async {

                  log("pressed connect");
                  // user has account
                  if (userAttributes.getHasAccount()) {
                    log("has acc");
                    // if user has spot
                    if (userAttributes.getConnectedToSpotify()) {
                      log("has spot");
                      log("uid nefore is " + widget.coasterUid);
                      hostCoasterDetails = await addCoasterWithoutTapping(widget.coasterUid);
                      log("status code is " + hostCoasterDetails.statusCode.toString());
                      // if added success
                      if (hostCoasterDetails.statusCode == 204) {
                        // throw rename modal
                        await showDialog(
                            context: context,
                            builder: (popupContext) {
                              return RenameCoasterField(coasterUid: widget.coasterUid, popupContext: popupContext, coasterName: hostCoasterDetails.coasterName,);
                            }
                        );
                        hostCoasterDetails.statusCode = 201;
                        widget.notifyParent();
                      }
                    }
                    // else prompt to connect spot
                    else {
                      log("no spot");
                      await connectSpotify();
                      // link to spotify
                      await userAttributes.determineIfUserConnectedToSpotify();
                    }
                  }
                  // else prompt to create acc
                  else {
                    log("no acc");
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
                                            topLeft: const Radius.circular(
                                                25.0),
                                            topRight: const Radius.circular(
                                                25.0))),
                                    child: CreateAccountPrompt(notifyParent: widget.notifyParent, popupContext: bc),
                                  ),
                                )
                              ]
                          );
                        });
                  }

                  // Timer(Duration(seconds: 1),
                  //         () => widget.loginCallback());
                },
                child: Text(
                  '${(userAttributes.getConnectedToSpotify())? 'connect to coaster' : 'connect to Spotify'}',
                  style: TextStyle(
                    fontFamily: FONZFONTTWO,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                color: LILAC,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ),

          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child:
            Center(
              child: FlatButton(
                onPressed: () async {

                  launchedNfcToJoinParty = false;
                  pressedNfcButtonToJoinPartu = false;
                  widget.notifyParent();
                  // Timer(Duration(seconds: 1),
                  //         () => widget.loginCallback());
                },
                child: Text(
                  'no thanks',
                  style: TextStyle(
                    fontFamily: FONZFONTTWO,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: LILAC,
                  ),
                ),
                color: DARKERGREY,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ),

          ),
        ],
      ),
    );
  }
}
