import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/CoasterObject.dart';
import 'package:fonz_music_flutter/HostTab/CoasterDashboardViews/AddCoasterButton.dart';
import 'package:fonz_music_flutter/NfcFunctions/HostNfcFunctions.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/FailPartyJoin.dart';

import 'CoasterDashboardViews/CoasterDashboardView.dart';
import 'CoasterDashboardViews/NameYourNewCoaster.dart';
import 'CoasterDashboardViews/RewriteCoasterCircle.dart';
import 'TapYourPhoneLilac.dart';

bool pressedToConnectNewCoaster = false;
CoasterObject newConnectedCoasterDetails = CoasterObject("", "", "", "");
bool launchedNfcForNewCoaster = false;
bool needToRewriteNewCoaster = false;


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
          Container(
              width: width,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Padding(
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
              )
          ),
          Spacer(),
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
    log("the code in dashboard is " + newConnectedCoasterDetails.statusCode.toString());

    if (launchedNfcForNewCoaster) {

      // else {
      // if successful
      if (newConnectedCoasterDetails.statusCode == 204) {

        // writes url + uid on coaster
        if (needToRewriteNewCoaster) {
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
              needToRewriteNewCoaster = false;
              pressedToConnectNewCoaster = true;
              setState(() {});
            });
            return Container(
                child: Container(
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
        if (newConnectedCoasterDetails.statusCode == 200) {
          return Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, height * 0.1),
            child: FailPartyJoin(
              errorMessage: "this coaster belongs to " + newConnectedCoasterDetails.coasterName + " & is named " + newConnectedCoasterDetails.hostName,
              errorImage: getDisableIcon(),
            ),
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
        return TapYourPhoneLilac();
      }
      else {
        return Container(
          height: height * 0.55,
          child: Stack(

            children: [
              Column(
                children: [
                  Container(
                    height: height * 0.55,
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
        );
      }
    }
  }
}