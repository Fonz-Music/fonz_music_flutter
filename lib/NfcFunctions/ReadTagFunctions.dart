import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestGetCoasterApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/CoasterObject.dart';

import 'package:nfc_in_flutter/nfc_in_flutter.dart';


class ReadTagFunctions {

  // for platform specific code
  static const platformVar = const MethodChannel("readUidPlatform");


  static Future<String> readTagUid() async {

      bool _isNFCSupported = await NFC.isNDEFSupported;
      var uid;

      if (_isNFCSupported) {
        if (Platform.isIOS) {
          uid = await getNFCTagForIos();
          log("uid maybe? " + uid);
          return uid.toUpperCase();
        } else {
          // jay test this w android, otherwise just put legacy code in
          uid = await _scanForUidOnAndroid();
          log("uid maybe? " + uid);
          return uid.toUpperCase();
        }

      } else {
        // Indicates that the user's device doesn't support nfc
        log("nfc not supported");
        return "NFC_NOT_SUPPORTED";
      }
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

  static Future<String> getNFCTagForIos() async {
    String message;
    try {
      var result = await platformVar.invokeMethod('getNFCTag');
      message = result;
      log("uid is " + message);
      return message;
    } on PlatformException catch (e) {
      return e.message.toString();
    }
  }

}
