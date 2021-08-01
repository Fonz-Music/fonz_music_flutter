


import 'dart:developer';

import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestGetCoasterApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/CoreUserAttributes.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/CoasterObject.dart';
import 'package:fonz_music_flutter/NfcFunctions/GuestNfcFunctions.dart';

Future<CoasterObject> scanForCoasterDetails() async {
  log("starting the scan");
  // create coaster object
  CoasterObject hostCoasterDetails = CoasterObject("hostName", "coasterName", "sessionId", "coasterUid");
  // get uid from coaster
  String uidFromScannedCoaster = await GuestNfcFunctions.readNfcToJoinParty();
  uidFromScannedCoaster = "045EDE1AE66C80";
  if (uidFromScannedCoaster.length > 20) {
    hostCoasterDetails.statusCode = 0;
  }
  else {
    log("return from scan");
    // semd uid to api
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

      // }
    }
    else if (hostDetails["statusCode"] == 403 && hostDetails["code"] == "COASTER_NO_HOST") {
      hostCoasterDetails.statusCode = 600;
    }
  }

  return hostCoasterDetails;
}
