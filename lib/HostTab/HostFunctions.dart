

import 'dart:developer';

import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestGetCoasterApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/HostApi/CoasterManagementApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/CoasterObject.dart';
import 'package:fonz_music_flutter/NfcFunctions/HostNfcFunctions.dart';


Future<CoasterObject> addCoasterDashboardPage() async {
  
  var coasterResponse = CoasterObject("", "", "", "");
  
  var coasterDetails = await HostNfcFunctions.readCoasterUid();

  if (coasterDetails[1].length < 25) {
    log(coasterDetails[1].length.toString());
    coasterResponse.setEncodeCoaster(true);
  }
  // firstConnectedCoasterDetails
  // check to see if that coaster is ours and if its already connected to this host
  Map checkCoasterResponse = await CoasterManagementApi.getSingleOwnedCoaster(coasterDetails[0]);
  coasterResponse.coasterUid = coasterDetails[0];
  coasterResponse.setStatusCode(checkCoasterResponse["statusCode"]);
  // coasterResponse.statusCode = checkCoasterResponse["statusCode"];

  log("resp is " + checkCoasterResponse.toString());

  Map guestCoasterResponse;

  if (checkCoasterResponse["statusCode"] == 404 ) {
    // check if coaster is owned by someone else
    guestCoasterResponse = await GuestGetCoasterApi.getCoasterDetails(coasterDetails[0]);
    // if not owened, add it
    if (guestCoasterResponse["statusCode"] == 204) {
      Map addCoasterResponse = await CoasterManagementApi
          .addCoaster(coasterDetails[0]);
      log("second resp code: " +
          addCoasterResponse["statusCode"].toString());
      if (addCoasterResponse["statusCode"] != 200 ) {
        coasterResponse.setStatusCode(addCoasterResponse["statusCode"]);
        // coasterResponse.statusCode = addCoasterResponse["statusCode"];
      }
      else {
        coasterResponse.setStatusCode(204);
        // coasterResponse.statusCode = 204;
      }
    }
  }

  if (checkCoasterResponse["statusCode"] == 200) {
    log("code was 200 so naming coaster");
    // FirebaseAnalytics().logEvent(name: "hostTappedSomeoneElsesCoaster", parameters: {'string': "host"});
    coasterResponse.coasterName = checkCoasterResponse["body"]["name"];
    // newConnectedCoasterDetails.hostName = checkCoasterResponse["body"]["displayName"];
    coasterResponse.hostName = "host";
    coasterResponse.setStatusCode(200);
  }
  else if (guestCoasterResponse["statusCode"] == 200) {
    coasterResponse.coasterName = guestCoasterResponse["body"].coaster.name;
    // newConnectedCoasterDetails.hostName = checkCoasterResponse["body"]["displayName"];
    coasterResponse.hostName = "host";
    coasterResponse.setStatusCode(403);
  }


}

// dep 9 aug

// Map checkCoasterResponse = await GuestGetCoasterApi.getCoasterDetails(coasterDetails[0]);
// Map checkCoasterResponse = await GuestGetCoasterApi.getCoasterDetails(coasterDetails);


//
// log("lenght of url is " + coasterDetails[1].length.toString());
//
// newConnectedCoasterDetails.coasterUid = coasterDetails[0];
// newConnectedCoasterDetails.statusCode = checkCoasterResponse["statusCode"];
// log("status code is " + newConnectedCoasterDetails.statusCode.toString());
// log(checkCoasterResponse["body"].toString());
//
// if (checkCoasterResponse["statusCode"] == 204) {
//   // if it is already connected, nav to next page
//   log("code was 204 so adding coaster");
//
//   Map addCoasterResponse = await CoasterManagementApi
//       .addCoaster(coasterDetails[0]);
//   log("second resp code: " +
//       addCoasterResponse["statusCode"].toString());
//   if (addCoasterResponse["statusCode"] != 200) {
//     // if it is already connected, nav to next page
//     newConnectedCoasterDetails.statusCode =
//     addCoasterResponse["statusCode"];
//     FirebaseAnalytics().logEvent(name: "hostAddCoasterFail", parameters: {'string': "host"});
//   }
//   else {
//   FirebaseAnalytics().logEvent(name: "hostAddCoaster", parameters: {'string': "host"});
//   }
// }