import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestGetCoasterApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/CoasterObject.dart';
import 'package:fonz_music_flutter/MainTabs/SearchTab.dart';
import 'package:fonz_music_flutter/NfcFunctions/GuestNfcFunctions.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/FailPartyJoin.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/HostAPartyButton.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/JoinAPartyButton.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/JoinSuccessfulCircle.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/TapYourPhoneAmber.dart';

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
                  "search",
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
          HomePageMainBody(),
          Spacer()
        ],
      ),
    );
  }

  Widget HomePageMainBody()  {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    // use this to update the view
    refresh() {
      setState(() {});
      log("being rebuilt");
    }

    log("pressed nfc " + pressedNfcButtonToJoinPartu.toString());
    log("the code is " + hostCoasterDetails.statusCode.toString());

    if (launchedNfcToJoinParty) {



        // if successful
        if (hostCoasterDetails.statusCode == 200) {
          Timer(Duration(milliseconds: SUCCESSPAGELENGTH), () {
            widget.controller.animateToPage(1,
                duration: Duration(seconds: 1), curve: Curves.easeInOutCirc);
            connectedToAHost = true;
          });

          return Container(
            child: JoinSuccessfulCircle(connectedCoasterName: hostCoasterDetails.coasterName, coasterHostName: hostCoasterDetails.hostName),
          );
        }
        // if unsuccessful
        else {
          Timer(Duration(seconds: 10), () {
            launchedNfcToJoinParty = false;
            refresh();
          });
          if (hostCoasterDetails.statusCode == 600) {
            return Container(
              child: FailPartyJoin(
                errorMessage: "this coaster lacks a host",
                errorImage: getDisableIcon(),
              ),
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
              HostAPartyButton(),
              Spacer(),
              JoinAPartyButton(notifyParent: refresh),
          ],
        ),
      );
    }
  }


}
