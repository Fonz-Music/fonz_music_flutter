import 'dart:async';
import 'dart:developer';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/CoasterObject.dart';
import 'package:fonz_music_flutter/MainTabs/SearchTab.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/ConnectSpotifyHomePage.dart';

import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/HomePageResponses/FailPartyJoin.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/HostAPartyButton.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/JoinAPartyButton.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/HomePageResponses/JoinSuccessfulCircle.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/TapYourPhoneAmber.dart';
import 'package:fonz_music_flutter/main.dart';

import 'HomePageWidgets/BuyACoasterHomeButton.dart';
import 'HomePageWidgets/HomePageResponses/CoasterHasNoHost.dart';

bool pressedNfcButtonToJoinPartu = false;
CoasterObject hostCoasterDetails = CoasterObject("", "", "", "");
bool launchedNfcToJoinParty = false;

class HomeDecisionPage extends StatefulWidget {

  HomeDecisionPage({Key key, this.controller, this.currentTab, this.notifyParent}) : super(key: key);
  PageController controller;
  int currentTab;
  final Function() notifyParent;

  @override
  _HomeDecisionPageState createState() => _HomeDecisionPageState();
}

class _HomeDecisionPageState extends State<HomeDecisionPage> {

  // use this to update the view
  refresh() {
    setState(() {});
    log("being rebuilt");
  }




  @override
  Widget build(BuildContext context) {



    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      child:  Column(
        children: [
          Container(
              width: width,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: new Text(
                  "queue",
                  style: TextStyle(
                    fontFamily: FONZFONTTWO,
                    fontSize: HEADINGTHREE,
                    color: determineColorThemeTextInverse(),
                  ),
                  textAlign: TextAlign.left,
                ),
              )
          ),
          Spacer(),
          HomePageMainBody(widget.currentTab, widget.notifyParent),
          Spacer()
        ],
      ),
    );
  }

  Widget HomePageMainBody(notifyParent, currentTab)  {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    // use this to update the view
    refresh() {
      setState(() {});
      log("being rebuilt");
    }

    // log("pressed nfc " + pressedNfcButtonToJoinPartu.toString());
    // log("the code is " + hostCoasterDetails.statusCode.toString());

    if (launchedNfcToJoinParty) {



        // if successful
        if (hostCoasterDetails.statusCode == 200) {
          // this tells firebase there was a successful party join
          FirebaseAnalytics().logEvent(
              name: "guestJoinedSession", parameters: {'string': "guest"});
          Timer(Duration(milliseconds: SUCCESSPAGELENGTH), () {
            widget.controller.animateToPage(1,
                duration: Duration(seconds: 1), curve: Curves.easeInOutCirc);
            connectedToAHost = true;

            widget.notifyParent();
          });
          Timer(Duration(seconds: 5), () {
            launchedNfcToJoinParty = false;
            pressedNfcButtonToJoinPartu = false;
          });

          return Container(
            child: JoinSuccessfulCircle(connectedCoasterName: hostCoasterDetails.coasterName, coasterHostName: hostCoasterDetails.hostName),
          );
        }
        // if unsuccessful
        else {
          Timer(Duration(seconds: 5), () {
            launchedNfcToJoinParty = false;
            pressedNfcButtonToJoinPartu = false;
            refresh();
          });
          if (hostCoasterDetails.statusCode == 600) {
            FirebaseAnalytics().logEvent(name: "guestTappedUnownedCoaster", parameters: {'string': "guest"});
            return CoasterHasNoHost(tabSelected: widget.currentTab, notifyParent: widget.notifyParent );
          }
          else if (hostCoasterDetails.statusCode == 0) {
            FirebaseAnalytics().logEvent(name: "guestDoesntSupportNfc", parameters: {'string': "guest"});
            return FailPartyJoin(
              errorMessage: "your phone doesn't support NFC",
              errorImage: getDisableIcon(),
            );
          }
          else {
            return Container(
              child: FailPartyJoin(
                errorMessage: "something went wrong",
                errorImage: getDisableIcon(),
              ),
            );
          }
        }

    }
    else {
      if (pressedNfcButtonToJoinPartu) {
        Timer(Duration(seconds: 10), () {
          pressedNfcButtonToJoinPartu = false;
          if (!launchedNfcToJoinParty) {
            refresh();
          }

        });
        return TapYourPhoneAmber();
      }
      return Container(
        height: height * 0.7,
        child: Column(
          children: [
              Row(
                children: [
                  Spacer(),
                  DetermineIfSpotifyHomeButtonShown(),
                  BuyACoasterHomeButton(),
                  Spacer(),
                ],
              ),
              // HostAPartyButton(notifyParent: widget.notifyParent,),
              Container(
                  height: height * 0.1,
                  // child: Spacer()
              ),
              JoinAPartyButton(notifyParent: refresh),
          ],
        ),
      );
    }
  }

  Widget DetermineIfHomeButtonsShow() {

  }


  Widget DetermineIfSpotifyHomeButtonShown() {
    if (!userAttributes.getConnectedToSpotify()) {
      return  Row(
        children: [
          ConnectSpotifyHomePageButton(notifyParent: widget.notifyParent),
          Container(
            // width: 30,

          ),
        ],
      );
  }
    else return Container(
      width: 0,
    );
  }


}
