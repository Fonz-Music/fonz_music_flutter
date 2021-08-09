import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestGetCoasterApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/CoasterObject.dart';

import 'package:nfc_in_flutter/nfc_in_flutter.dart';


class GuestNfcFunctions {

  // readHostNFC() combines the other functions
  static Future<String> readNfcToJoinParty() async {

    String uidFromScannedCoaster;
    bool _isNFCSupported = await NFC.isNDEFSupported;
    try {
      // CoasterInfo coaster;
      if (_isNFCSupported) {

        log("scanning for nfc");
        uidFromScannedCoaster = await _scanForUidOnAndroid();

      }
      else {
        log("device does not support");
        uidFromScannedCoaster = "this device does not support NFC";
      }
    }
    catch (e) {
      uidFromScannedCoaster = "this coaster is not registered by Fonz or the guest quit the NFC prompt";
    }
    return uidFromScannedCoaster;
  }

  // // readHostNFC() combines the other functions
  // static Future<CoasterObject> readNfcToJoinParty() async {
  //   CoasterObject returnCoaster;
  //
  //   var uidFromScannedCoaster;
  //   bool _isNFCSupported = await NFC.isNDEFSupported;
  //   try {
  //     // CoasterInfo coaster;
  //     if (_isNFCSupported) {
  //
  //       log("scanning for nfc");
  //       uidFromScannedCoaster = await _scanForUidOnAndroid();
  //
  //
  //       Map hostDetails = await GuestGetCoasterApi.getCoasterDetails(uidFromScannedCoaster.toUpperCase());
  //       log("resp from api " + hostDetails.toString());
  //       log("resp code " + hostDetails["responseCode"].toString());
  //       if (hostDetails["responseCode"] == 200) {
  //         log("getting this far");
  //         if (hostDetails["body"]["displayName"] == null) {
  //           returnCoaster.returnMessage = "don't think your host is connected to this coaster :/";
  //         }
  //         else {
  //           returnCoaster.coasterUid = uidFromScannedCoaster;
  //           returnCoaster.hostName = hostDetails["body"]["displayName"];
  //           returnCoaster.coasterName = hostDetails["body"]["coasterName"];
  //           returnCoaster.sessionId = hostDetails["body"]["sessionId"];
  //           log("stored coaster ");
  //           returnCoaster.returnMessage = "success";
  //         }
  //       }
  //       else {
  //         returnCoaster.returnMessage =
  //         "not sure this is a Fonz Coaster...";
  //       }
  //     }
  //     else {
  //       log("device does not support");
  //       returnCoaster.returnMessage = "this device does not support NFC";
  //     }
  //   }
  //   catch (e) {
  //     returnCoaster.returnMessage = "this coaster is not registered by Fonz or the guest quit the NFC prompt";
  //   }
  //   log("return msg " + returnCoaster.returnMessage);
  //   return returnCoaster;
  // }

  // potential vulnerablity. We do not cross reference the uid scanned to make sure
  // its the same coaster or even ASSOCIATED with the same account.
  static Future<String> readHostNFCForQueue() async {
    String returnMessage = "";
    bool _isNFCSupported = await NFC.isNDEFSupported;
    try {
      if (_isNFCSupported) {
          var uidFromScannedCoaster = await _scanForUidOnAndroid();
          returnMessage = uidFromScannedCoaster;
      } else {
        log("device does not support");
        returnMessage = "this device does not support NFC";
      }
    }
    catch (e) {
      returnMessage = "this coaster is not registered by Fonz or the guest quit the NFC prompt";
    }
    return returnMessage;
  }

  // scanns for and checks for the uid on android
  static Future<String> _scanForUidOnAndroid() async {
    String coasterUid;
    Stream<NDEFMessage> _stream;

    _stream = NFC.readNDEF(alertMessage: 'Looking for a Fonz!', once: false, readerMode: NFCDispatchReaderMode());
    _stream.handleError((error) {
      if (error is NFCUserCanceledSessionException) {
        log("user canceled session ");
        Exception(error.toString());
      } else if (error is NFCSessionTimeoutException) {
        log("session time out");
        Exception(error.toString());
      } else {
        log("strange ");
        Exception(error.toString());
      }
      return null;
    });
    NDEFMessage record = await _stream.first;

    coasterUid = record.id;
    log("uid from id " + record.id.toString());
    log("getting caught here");
    return coasterUid;
  }

}
