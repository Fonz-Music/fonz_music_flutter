import 'dart:async';
import 'dart:developer';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalFunctions/LaunchShop.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalSessionVariables.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/CoasterObject.dart';
import 'package:fonz_music_flutter/HostTab/CoasterDashboardViews/AddCoasterButton.dart';
import 'package:fonz_music_flutter/NfcFunctions/HostNfcFunctions.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/HomePageResponses/FailPartyJoin.dart';

import '../main.dart';
import 'CoasterDashboardViews/CoasterDashboardView.dart';
import 'CoasterDashboardViews/NameYourNewCoaster.dart';
import 'CoasterDashboardViews/RewriteCoasterCircle.dart';
import 'HostNfcResponses/CoasterHasDifferentHost.dart';
import 'HostNfcResponses/ThisIsYourCoasterResponse.dart';
import 'TapYourPhoneLilac.dart';

bool pressedToConnectNewCoaster = false;
CoasterObject newConnectedCoasterDetails = CoasterObject("", "", "", "");
bool launchedNfcForNewCoaster = false;



class CoasterDashboardPage extends StatefulWidget {

  CoasterDashboardPage({Key key, this.controller, this.currentTab, this.notifyParent}) : super(key: key);
  PageController controller;
  int currentTab;
  final Function() notifyParent;

  @override
  _CoasterDashboardPageState createState() => _CoasterDashboardPageState();
}

class _CoasterDashboardPageState extends State<CoasterDashboardPage> {


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final width = size.width;
    final height = size.height;

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              // Container(
              //     width: width,
              //     padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              //     child:
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                    child: new Text(
                      "coasters",
                      style: TextStyle(
                        fontFamily: FONZFONTTWO,
                        fontSize: HEADINGTHREE,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  // )
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: NeumorphicButton(
                  child: Container(
                    width: 25,
                    height: 25,
                    child:
                    Container(
                      // padding: const EdgeInsets.all(5),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: determineColorThemeTextInverse(),
                        size: 18,
                      )
                      // child: Image(
                      //   image: AssetImage(getLeavePartyIcon()),
                      //
                      // ),
                    ),
                  ),
                  padding: EdgeInsets.all(7),
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.circle(),
                      // border: NeumorphicBorder(width: 2, color: LILAC),
                      color: determineColorThemeBackground(),
                      shadowDarkColor: determineLightShadowRoundButton(),
                      shadowLightColor: determineLightShadowRoundButton()
                  ),
                  onPressed: () async {
                    launchShop();
                  },

                ),
              ),
            ],
          ),
          Container(
            height: height * 0.1
          ),
          CoasterDashboardMainBody(),
          // Spacer()
        ],
      ),
    );
  }

  Widget CoasterDashboardMainBody()  {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;


    // use this to update the view
    refresh() {
      setState(() {});
      log("host setup being rebuilt");
    }

    log("pressed nfc in dashboard  " + pressedToConnectNewCoaster.toString());
    log("the code in dashboard is " + newConnectedCoasterDetails.coasterUid.toString());

    if (launchedNfcForNewCoaster) {

      // else {
      // if successful
      if (newConnectedCoasterDetails.statusCode == 204) {
        FirebaseAnalytics().logEvent(name: "userConnectCoaster", parameters: {
          'user': "guest",
          "sessionId":newConnectedCoasterDetails.sessionId,
          "userId":userAttributes.getUserId(),
          "group":groupFromCoaster,
          "tagUid":newConnectedCoasterDetails.coasterUid,
          "device":"android"
        });
        // writes url + uid on coaster
        if (newConnectedCoasterDetails.needToEncodeCoaster) {
          // tells user they need to connect to their account
          if (!pressedToConnectNewCoaster){
            Timer(Duration(milliseconds: 2000), () async {
              pressedToConnectNewCoaster = true;
              setState(() {});
            });
            return Container(
                child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, height * 0.1),
                    child: RewriteCoasterCircle()
                )
            );
          }
          // shows tap phone icon & launches nfc
          else {
            Timer(Duration(milliseconds: 0), () async {
              await HostNfcFunctions.writeNFC(newConnectedCoasterDetails.coasterUid);
              newConnectedCoasterDetails.setEncodeCoaster(false);
              pressedToConnectNewCoaster = true;
              setState(() {});
            });
            return Container(
                child: Container(
                    decoration: BoxDecoration(
                        color: determineColorThemeBackground(),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.fromLTRB(20, 0, 20, height * 0.1),
                    child: TapYourPhoneLilac()
                )
            );
          }
        }
        else {
          // name coaster
          return Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, height * 0.1),
            child: NameYourNewCoaster(notifyParent: refresh),
            // child: JoinSuccessfulCircle(connectedCoasterName: hostCoasterDetails.coasterName, coasterHostName: hostCoasterDetails.hostName),
          );
        }



      }
      // if unsuccessful
      else {
        Timer(Duration(seconds: 5), () {
          // pressedToConnectFirstCoaster = false;
          launchedNfcForNewCoaster = false;
          refresh();
        });
        // if someone else's coaster
        if (newConnectedCoasterDetails.statusCode == 403) {
          return Container(
            decoration: BoxDecoration(
                color: determineColorThemeBackground(),
                borderRadius: BorderRadius.circular(10)
            ),
            // padding: EdgeInsets.fromLTRB(20, 0, 20, height * 0.1),
            child: CoasterHasDifferentHost(connectedCoasterName: newConnectedCoasterDetails.coasterName, coasterHostName: newConnectedCoasterDetails.hostName,),
          );
        }
        // if your existing coaster
        else if (newConnectedCoasterDetails.statusCode == 200) {
          return Container(
              decoration: BoxDecoration(
                  color: determineColorThemeBackground(),
                  borderRadius: BorderRadius.circular(10)
              ),
            padding: EdgeInsets.fromLTRB(20, 0, 20, height * 0.1),
            child: ThisIsYourCoaster(connectedCoasterName: newConnectedCoasterDetails.coasterName)
          );
        }
        else {
          return Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, height * 0.1),
            child: FailPartyJoin(
              errorMessage: "something went wrong",
              errorImage: getDisableIcon(),
            ),
          );
        }
      }
      // }
    }
    else {
      if (pressedToConnectNewCoaster) {
        Timer(Duration(seconds: 15), () {
          pressedToConnectNewCoaster = false;
          if (!launchedNfcForNewCoaster) {
            refresh();
          }

        });
        return Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
              color: determineColorThemeBackground(),
              borderRadius: BorderRadius.circular(10)
          ),
          child: TapYourPhoneLilac(),

        );
      }
      else {
        return Expanded(
          child: Column(
            children: [
              Spacer(),
              Container(
                height: height * 0.65,
                child: Stack(

                  children: [
                    Column(
                      children: [
                        Container(
                          height: height * 0.65,
                          decoration: BoxDecoration(
                            color: determineColorThemeBackground(),
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ],
                    ),

                    Column(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          // height: height * 0.7,
                          child: CoasterDashboardView(notifyParent: refresh,)
                      ),
                      // add new coaster button
                      Spacer(),
                      AddCoasterButton(notifyParent: refresh,)
                    ],
                  ),
    ]
                ),
              ),
            ],
          ),
        );
      }
    }
  }
}