import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestGetCoasterApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/CoasterObject.dart';
import 'package:fonz_music_flutter/NfcFunctions/GuestNfcFunctions.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/HostAPartyButton.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/JoinAPartyButton.dart';

class HomeDecisionPage extends StatefulWidget {

  HomeDecisionPage({Key key, this.controller, this.currentTab, this.notifyParent}) : super(key: key);
  PageController controller;
  int currentTab;
  final Function() notifyParent;

  @override
  _HomeDecisionPageState createState() => _HomeDecisionPageState();
}

class _HomeDecisionPageState extends State<HomeDecisionPage> {
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
                    color: determineColorThemeText(),
                  ),
                  textAlign: TextAlign.left,
                ),
              )
          ),
          Spacer(),
          HostAPartyButton(),
          Spacer(),
          JoinAPartyButton(),
          Spacer()
        ],
      ),
    );
  }

  Future<CoasterObject> scanForCoasterDetails() async {
    // create coaster object
    CoasterObject hostCoasterDetails;
    // get uid from coaster
    String uidFromScannedCoaster = await GuestNfcFunctions.readNfcToJoinParty();
    // semd uid to api
    Map hostDetails = await GuestGetCoasterApi.getCoasterDetails(
        uidFromScannedCoaster.toUpperCase());
    // for debug
    log("resp from api " + hostDetails.toString());
    log("resp code " + hostDetails["responseCode"].toString());

    // sets status code
    hostCoasterDetails.statusCode = hostDetails["responseCode"];
    // if successful, set info
    if (hostDetails["responseCode"] == 200) {
      log("getting this far");
      // if there is no host
      if (hostDetails["body"]["displayName"] == null) {
        hostCoasterDetails.statusCode = 600;
      }
      // if there is a host, set it
      else {
        hostCoasterDetails.coasterUid = uidFromScannedCoaster;
        hostCoasterDetails.hostName = hostDetails["body"]["displayName"];
        hostCoasterDetails.coasterName = hostDetails["body"]["coasterName"];
        hostCoasterDetails.sessionId = hostDetails["body"]["sessionId"];
        log("stored coaster ");
      }
    }
    return hostCoasterDetails;
  }
}
