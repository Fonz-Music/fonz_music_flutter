import 'dart:async';

import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:fonz_music_flutter/GlobalComponents/ExceptionHandling.dart';


import 'package:nfc_in_flutter/nfc_in_flutter.dart';





// Host class contains the static methods for writing to the coaster
class WriteTagFunctions {
// for platform specific code
  static const platformVar = const MethodChannel("readUidPlatform");

  // Writes the needed information to the coaster
  static Future<bool> writeUrlOnTag(String uid) async {
    // try {
      bool wroteSuccessfully = false;

      // do you need this? since its always called in _grabCoasterUid() anyways
      bool _isNFCSupported = await NFC.isNDEFSupported;
      //

      if (_isNFCSupported) {
        log("nfc is suppoted");
//        var _stream =
        if (Platform.isIOS) {
          var writeResp = await writeNFCTagForIos(uid);
          if (writeResp == "SUCCESS_ON_WRITE") wroteSuccessfully = true;
        } else {
          var writeAndroid = await NFC.writeNDEF(await buildUrlWithUid(uid), message: 'Activating your Fonz Coaster!', once: true).first;
          wroteSuccessfully = true;
        }


        log("uid is: " + uid);
//        log("uid is: " + uid);
        // will addCoaster on the page
//        await HostApi.addCoaster(uid);
      } else {
        log("nfc isnt suppoted");
        // throw new NfcNotSupportedException();
      }
      return wroteSuccessfully;

  }

  static Future<NDEFMessage> buildUrlWithUid(String uid) async {
    List<NDEFRecord> _records = [];
    var fonzUrl = Uri(path: "fonzmusic.com/" + uid, scheme: "https://");
    NDEFRecord url = new NDEFRecord.uri(fonzUrl);

    _records.add(url);
    return NDEFMessage.withRecords(_records);
  }

  static Future<void> updateNFC() async {
    bool _isNdefSupported = await NFC.isNDEFSupported;
  }

  static Future<String> writeNFCTagForIos(String uid) async {
    String message;
    try {
      var result = await platformVar.invokeMethod('writeFonzUrl', {"uid": uid});
      message = result;
      log("uid is " + message);
      return message;
    } on PlatformException catch (e) {
      return e.message.toString();
    }
  }


}