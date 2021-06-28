import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestGetCoasterApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/HostApi/CoasterManagementApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/NfcFunctions/HostNfcFunctions.dart';

import '../CoasterDashboardPage.dart';

class AddCoasterButton extends StatefulWidget {

  AddCoasterButton({Key key, this.notifyParent}) : super(key: key);
  final Function() notifyParent;

  @override
  _AddCoasterButtonState createState() => _AddCoasterButtonState();
}

class _AddCoasterButtonState extends State<AddCoasterButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: MaterialButton(
            shape: CircleBorder(
                side: BorderSide(color: Colors.white, width: 2)
            ),
            color: LILAC,
            padding: EdgeInsets.all(20),
            onPressed: () async {
              pressedToConnectNewCoaster = true;
              widget.notifyParent();

              var coasterDetails = await HostNfcFunctions.readCoasterUid();
              // firstConnectedCoasterDetails
              // check to see if that coaster is ours and if its already connected
              // CHECK COASTER
              Map checkCoasterResponse = await GuestGetCoasterApi.getCoasterDetails(coasterDetails[0]);

              if (coasterDetails[1].length < 25) {
                log(coasterDetails[1].length.toString());
                needToRewriteNewCoaster = true;
              }

              log(coasterDetails[1].length.toString());

              newConnectedCoasterDetails.coasterUid = coasterDetails[0];
              newConnectedCoasterDetails.statusCode = checkCoasterResponse["responseCode"];

              log(checkCoasterResponse["body"].toString());

              if (checkCoasterResponse["responseCode"] == 204) {
                // if it is already connected, nav to next page

                Map addCoasterResponse = await CoasterManagementApi
                    .addCoaster(coasterDetails[0]);
                log("second resp code: " +
                    addCoasterResponse["responseCode"].toString());
                if (addCoasterResponse["responseCode"] != 200) {
                  // if it is already connected, nav to next page
                  newConnectedCoasterDetails.statusCode =
                  addCoasterResponse["responseCode"];
                  FirebaseAnalytics().logEvent(name: "hostAddCoasterFail", parameters: {'string': "host"});
                }
                else {
                FirebaseAnalytics().logEvent(name: "hostAddCoaster", parameters: {'string': "host"});
                }
              }
              else if (checkCoasterResponse["responseCode"] == 200) {
                FirebaseAnalytics().logEvent(name: "hostTappedSomeoneElsesCoaster", parameters: {'string': "host"});
                newConnectedCoasterDetails.coasterName = checkCoasterResponse["body"]["name"];
                newConnectedCoasterDetails.hostName = checkCoasterResponse["body"]["displayName"];
              }

              pressedToConnectNewCoaster = false;
              launchedNfcForNewCoaster = true;
              widget.notifyParent();
            },
            child: Icon(
              Icons.add,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        Spacer()
      ],
    );
  }
}
