
import 'dart:developer';

import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestGetCoasterApi.dart';
import 'package:fonz_music_flutter/MainTabs/SearchTab.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageDecision.dart';

import '../CoreUserAttributes.dart';
import '../GlobalSessionVariables.dart';

checkCoasterDeepLink(String uidFromScannedCoaster) async {
  Map hostDetails = await GuestGetCoasterApi.getCoasterDetails(
      uidFromScannedCoaster.toUpperCase());
  // for debug
  log("resp from api " + hostDetails.toString());
  log("resp code " + hostDetails["statusCode"].toString());

  // sets status code
  hostCoasterDetails.setStatusCode(hostDetails["statusCode"]);
  // if successful, set info
  if (hostDetails["statusCode"] == 200) {
    log("getting this far");
    // if there is no host

    // if there is a host, set it
    // else {
    hostCoasterDetails.coasterUid = uidFromScannedCoaster;
    // hostCoasterDetails.hostName = hostDetails["body"].coaster.name;
    hostCoasterDetails.hostName = "host";
    hostCoasterDetails.coasterName = hostDetails["body"].coaster.name;
    hostCoasterDetails.sessionId = hostDetails["body"].session.sessionId;
    hostSessionIdGlobal = hostDetails["body"].session.sessionId;
    print("details are " + hostCoasterDetails.coasterName.toString());
    log("stored coaster ");
    connectedToAHost = true;

    // }
  }
  else if (hostDetails["statusCode"] == 403 && hostDetails["code"] == "COASTER_NO_HOST") {
    hostCoasterDetails.statusCode = 600;
    pressedNfcButtonToJoinPartu = true;
    launchedNfcToJoinParty = true;
  }
}