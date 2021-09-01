
import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestSpotifyApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/CoreUserAttributes.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalSessionVariables.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';
import 'package:fonz_music_flutter/NfcFunctions/GuestNfcFunctions.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageDecision.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/QueueSongResponses/QueueSongFail.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/QueueSongResponses/QueueSongSuccess.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/QueueSongResponses/QueuedButDelayed.dart';

import '../SearchPage.dart';

queueSongLaunchNfc(Track trackToQueue) async {
  log("going to queue " + trackToQueue.title);
  songAddedToQueue = trackToQueue.title;
  pressedToLaunchQueueNfc.value = true;
  var uidFromTap = await GuestNfcFunctions.readHostNFCForQueue();
  log("uid from tap is " + uidFromTap);
  log("uid from host coaster " + hostCoasterDetails.coasterUid);
  if (uidFromTap == hostCoasterDetails.coasterUid) {
    var queueTrackResponse = await GuestSpotifyApi.queueTrackSpotify(trackToQueue.trackID, hostSessionIdGlobal);
    if (queueTrackResponse["statusCode"] == 200) {
      log("succesful q");
      responseCodeFromQueue.value = "QUEUE_SUCCESS";
    }
    else if (queueTrackResponse["statusCode"] == 403) {
      log("q delay");
      responseCodeFromQueue.value = "QUEUED_BUT_DELAYED";
    }
    else {
      log("fail q");
      responseCodeFromQueue.value = "QUEUE_FAILURE";
    }
    pressedToLaunchQueueNfc.value = false;
  }
  else {
    log("not same coaster");
    responseCodeFromQueue.value = "NOT_SAME_COASTER";
    pressedToLaunchQueueNfc.value = false;
  }

  Timer(Duration(seconds: 5), () {
    if (pressedToLaunchQueueNfc.value) {
      log("timed out");
      pressedToLaunchQueueNfc.value = false;
    }
  });
}

queueSongWithoutNfc(Track trackToQueue, context) async {

  final size = MediaQuery.of(context).size;
  final width = size.width;

  log("going to queue " + trackToQueue.title);
  songAddedToQueue = trackToQueue.title;

  var queueTrackResponse = await GuestSpotifyApi.queueTrackSpotify(trackToQueue.trackID, hostSessionIdGlobal);
  if (queueTrackResponse["statusCode"] == 200) {
    log("succesful q");
    showToastWidget(Container(
      width: width * COMPONENTWIDTH,
      height: 60,
      child: QueueSongSuccess(),
    ), context: context, position: StyledToastPosition.top);
    // responseCodeFromQueue.value = "QUEUE_SUCCESS";
  }
  else if (queueTrackResponse["statusCode"] == 403) {
    log("q delay");
    showToastWidget(Container(
      width: width * COMPONENTWIDTH,
      height: 60,
      child: QueuedButDelayed(),
    ), context: context, position: StyledToastPosition.top);
    // responseCodeFromQueue.value = "QUEUED_BUT_DELAYED";
  }
  else {
    log("fail q");
    showToastWidget(Container(
      width: width * COMPONENTWIDTH,
      height: 60,
      child: QueueSongFail(),
    ), context: context, position: StyledToastPosition.top);
    // responseCodeFromQueue.value = "QUEUE_FAILURE";
  }

}