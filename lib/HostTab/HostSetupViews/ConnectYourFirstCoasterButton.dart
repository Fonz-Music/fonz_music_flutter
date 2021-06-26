import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestGetCoasterApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/HostApi/CoasterManagementApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/ExceptionHandling.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/MainTabs/HostTab.dart';
import 'package:fonz_music_flutter/NfcFunctions/HostNfcFunctions.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/scanForCoasterDetails.dart';

import '../HostSetup.dart';



class ConnectYourFirstCoasterButton extends StatefulWidget {

  ConnectYourFirstCoasterButton({Key key, @required this.notifyParent}) : super(key: key);

  final Function() notifyParent;

  @override
  _ConnectYourFirstCoasterButtonState createState() => _ConnectYourFirstCoasterButtonState();
}

class _ConnectYourFirstCoasterButtonState extends State<ConnectYourFirstCoasterButton> {
  @override
  Widget build(BuildContext context) {
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
                    image: AssetImage("assets/lightGreyIcons/coasterIconLightGrey.png"),

                  ),
                ),
              ),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  border: NeumorphicBorder(width: 2, color: Colors.white),
                  color: LILAC
              ),
              onPressed: () async {
                pressedToConnectFirstCoaster = true;
                widget.notifyParent();

                var coasterUid = await HostNfcFunctions.readCoasterUid();
                // firstConnectedCoasterDetails
                // check to see if that coaster is ours and if its already connected
                // CHECK COASTER
                Map checkCoasterResponse = await CoasterManagementApi.getSingleOwnedCoaster(coasterUid);

                firstConnectedCoasterDetails.coasterUid = coasterUid;
                firstConnectedCoasterDetails.statusCode = checkCoasterResponse["responseCode"];

                if (checkCoasterResponse["responseCode"] == 204) {
                  // if it is already connected, nav to next page

                  Map addCoasterResponse = await CoasterManagementApi.addCoaster(coasterUid);
                  log("second resp code: " +
                      addCoasterResponse["responseCode"].toString());
                  if (addCoasterResponse["responseCode"] == 200) {
                    // if it is already connected, nav to next page
                    firstConnectedCoasterDetails.statusCode = 700;
                  }
                } else if (checkCoasterResponse["responseCode"] == 200) {
                  Map otherHostsCoaster = await GuestGetCoasterApi.getCoasterDetails(coasterUid);
                  log(otherHostsCoaster.toString());
                  if (otherHostsCoaster["responseCode"] == 200) {
                    if (otherHostsCoaster["body"]["displayName"] != null) {
                      firstConnectedCoasterDetails.hostName = otherHostsCoaster["body"]["displayName"];
                      firstConnectedCoasterDetails.coasterName = otherHostsCoaster["body"]["name"];

                    } else {
                      //errorOccured = true;
                      // errorMessage =
                      // "the nfc TAP didn't work properly...\nor this coaster is not registered by Fonz";
                      throw new NotFonzException();
                    }
                  }
                }


                launchedNfcForFirstCoaster = true;
                widget.notifyParent();
              },

            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: new Text(
              "connect your first coaster",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGFOUR,
                color: determineColorThemeText(),
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }


}
