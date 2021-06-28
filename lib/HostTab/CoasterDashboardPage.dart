import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/CoasterObject.dart';
import 'package:fonz_music_flutter/HostTab/CoasterDashboardViews/AddCoasterButton.dart';
import 'package:fonz_music_flutter/HostTab/HostSetupViews/ConnectSpotifyButton.dart';
import 'package:fonz_music_flutter/HostTab/HostSetupViews/ConnectYourFirstCoasterButton.dart';
import 'package:fonz_music_flutter/HostTab/HostSetupViews/NameYourFirstCoaster.dart';
import 'package:fonz_music_flutter/MainTabs/HostTab.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/FailPartyJoin.dart';

import 'CoasterDashboardViews/CoasterDashboardView.dart';

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

        // Timer(Duration(milliseconds: SUCCESSPAGELENGTH), () {
        //   hasConnectedCoasters = true;
        //   widget.controller.animateToPage(1,
        //       duration: Duration(seconds: 1), curve: Curves.easeInOutCirc);
        // });


        // name coaster
        return Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, height * 0.1),
          child: NameYourFirstCoaster(notifyParent: refresh,controller: widget.controller),
          // child: JoinSuccessfulCircle(connectedCoasterName: hostCoasterDetails.coasterName, coasterHostName: hostCoasterDetails.hostName),
        );
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
        return Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, height * 0.1),
          child: Column(
            children: [
              // Spacer(),
              Text(
                  "tap your phone to the Fonz",
                  style: TextStyle(
                    fontFamily: FONZFONTTWO,
                    fontSize: HEADINGFOUR,
                    color: determineColorThemeTextInverse(),
                  ),
                  textAlign: TextAlign.center,
               
              ),
              Image(
                image: AssetImage("assets/fonzIcons/tapCoasterIconLilac.png"),
              ),
              // Spacer()
            ],
          ),
        );
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
                    child: CoasterDashboardView()
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