import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/CoasterObject.dart';
import 'package:fonz_music_flutter/HostTab/CoasterDashboardViews/RewriteCoasterCircle.dart';
import 'package:fonz_music_flutter/HostTab/HostSetupViews/ConnectSpotifyButton.dart';
import 'package:fonz_music_flutter/HostTab/HostSetupViews/ConnectYourFirstCoasterButton.dart';
import 'package:fonz_music_flutter/HostTab/HostSetupViews/NameYourFirstCoaster.dart';
import 'package:fonz_music_flutter/HostTab/TapYourPhoneLilac.dart';
import 'package:fonz_music_flutter/MainTabs/HostTab.dart';
import 'package:fonz_music_flutter/NfcFunctions/HostNfcFunctions.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/FailPartyJoin.dart';

import '../main.dart';

bool pressedToConnectFirstCoaster = false;
CoasterObject firstConnectedCoasterDetails = CoasterObject("", "", "", "");
bool launchedNfcForFirstCoaster = false;
bool needToRewriteFirstCoaster = false;


class HostSetupPage extends StatefulWidget {

  HostSetupPage({Key key, this.controller, this.currentTab, this.notifyParent}) : super(key: key);
  PageController controller;
  int currentTab;
  final Function() notifyParent;

  @override
  _HostSetupPageState createState() => _HostSetupPageState();
}

class _HostSetupPageState extends State<HostSetupPage> {






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
                  "host",
                  style: TextStyle(
                    fontFamily: FONZFONTTWO,
                    fontSize: HEADINGTHREE,
                    color: determineColorThemeText(),
                  ),
                  textAlign: TextAlign.left,
                ),
              )
          ),
          Spacer(),
          HostPageMainBody(),
          Spacer()
        ],
      ),
    );
  }

  Widget HostPageMainBody()  {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;


    // use this to update the view
    refresh() {
      setState(() {});
      log("host setup being rebuilt");
    }

    log("pressed nfc in host  " + pressedToConnectFirstCoaster.toString());
    log("the code in host is " + firstConnectedCoasterDetails.statusCode.toString());

    if (launchedNfcForFirstCoaster) {


      // else {
        // if successful
        if (firstConnectedCoasterDetails.statusCode == 204) {



          // writes url + uid on coaster
          if (needToRewriteFirstCoaster) {
            // tells user they need to connect to their account
            if (!pressedToConnectFirstCoaster){
              Timer(Duration(milliseconds: 2000), () async {
                pressedToConnectFirstCoaster = true;
                setState(() {});
              });
              return Container(
                  child: RewriteCoasterCircle()
              );
            }
            // shows tap phone icon & launches nfc
            else {
              Timer(Duration(milliseconds: 0), () async {
                await HostNfcFunctions.writeNFC(firstConnectedCoasterDetails.coasterUid);
                needToRewriteFirstCoaster = false;
                pressedToConnectFirstCoaster = true;
                setState(() {});
              });
              return Container(
                  child: TapYourPhoneLilac()
              );
            }

          }
          else {
            // name coaster
            return Container(
              child: NameYourFirstCoaster(notifyParent: refresh,controller: widget.controller),
              // child: JoinSuccessfulCircle(connectedCoasterName: hostCoasterDetails.coasterName, coasterHostName: hostCoasterDetails.hostName),
            );
          }



        }
        // if unsuccessful
        else {
          Timer(Duration(seconds: 5), () {
            // pressedToConnectFirstCoaster = false;
            launchedNfcForFirstCoaster = false;
            refresh();
          });
          if (firstConnectedCoasterDetails.statusCode == 200) {
            return Container(
              child: FailPartyJoin(
                errorMessage: "this coaster belongs to " + firstConnectedCoasterDetails.coasterName + " & is named " + firstConnectedCoasterDetails.hostName,
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
      // }
    }
    else {
      if (pressedToConnectFirstCoaster) {
        Timer(Duration(seconds: 15), () {
          pressedToConnectFirstCoaster = false;
          if (!launchedNfcForFirstCoaster) {
            refresh();
          }

        });
        return TapYourPhoneLilac();
      }
      else {
        return Container(
            height: height * 0.7,
            child: determineViewBasedOnSpotify(refresh)
        );
      }
    }
  }

  Widget determineViewBasedOnSpotify (notifyParent) {

    if (!connectedToSpotify) {
      return Column(
        children: [
          ConnectSpotifyButton(notifyParent: notifyParent),
          Spacer(),
          ConnectYourFirstCoasterButton(notifyParent: notifyParent)
        ],
      );

    }
    else
      return Column(
        children: [

          Spacer(),
          ConnectYourFirstCoasterButton(notifyParent: notifyParent),
          Spacer()
        ],
      );

    }

}
