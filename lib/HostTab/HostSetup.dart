import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/CoasterObject.dart';
import 'package:fonz_music_flutter/HostTab/HostSetupViews/ConnectSpotifyButton.dart';
import 'package:fonz_music_flutter/HostTab/HostSetupViews/ConnectYourFirstCoasterButton.dart';
import 'package:fonz_music_flutter/HostTab/HostSetupViews/NameYourFirstCoaster.dart';
import 'package:fonz_music_flutter/MainTabs/HostTab.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/FailPartyJoin.dart';

bool pressedToConnectFirstCoaster = false;
CoasterObject firstConnectedCoasterDetails = CoasterObject("", "", "", "");
bool launchedNfcForFirstCoaster = false;


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

          // Timer(Duration(milliseconds: SUCCESSPAGELENGTH), () {
          //   hasConnectedCoasters = true;
          //   widget.controller.animateToPage(1,
          //       duration: Duration(seconds: 1), curve: Curves.easeInOutCirc);
          // });


          // name coaster
          return Container(
            child: NameYourFirstCoaster(notifyParent: refresh,controller: widget.controller),
            // child: JoinSuccessfulCircle(connectedCoasterName: hostCoasterDetails.coasterName, coasterHostName: hostCoasterDetails.hostName),
          );
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
        return Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: new Text(
                  "tap your phone to the Fonz",
                  style: TextStyle(
                    fontFamily: FONZFONTTWO,
                    fontSize: HEADINGFOUR,
                    color: determineColorThemeText(),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Image(
                image: AssetImage("assets/fonzIcons/tapCoasterIconLilac.png"),
              ),
            ],
          ),
        );
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
