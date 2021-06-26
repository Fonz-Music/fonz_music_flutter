import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestGetCoasterApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/ExceptionHandling.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/CoasterObject.dart';

import 'package:nfc_in_flutter/nfc_in_flutter.dart';





// Host class contains the static methods for writing to the coaster
class HostNfcFunctions {

  // static var sessionId = HostApi.createSession();

  // Prompts the user to scan the coaster and returns the UID on completion,
  // otherwise it will throw an exception
  static Future<String> readCoasterUid() async {
    try {
      bool _isNFCSupported = await NFC.isNDEFSupported;
      var uid;

      if (_isNFCSupported) {

        uid = await _scanForUidOnAndroid();
        log("uid maybe? " + uid);
        return uid.toUpperCase();



      } else {
        // Indicates that the user's device doesn't support nfc
        log("nfc not supported");
        throw new NfcNotSupportedException();
      }
    } on NfcNotSupportedException catch (e, stacktrace) {
      await NfcNotSupportedException.report(stacktrace);
      return null;
    }
  }
//
//   // Writes the needed information to the coaster
//   static Future<bool> writeNFC(String uid) async {
//     try {
//       bool wroteSuccessfully = false;
//
//       // do you need this? since its always called in _grabCoasterUid() anyways
//       bool _isNFCSupported = await NFC.isNDEFSupported;
//       //
//       if (await sessionId == 'error creating sessionId') {
//         log('couldnt write to nfc, as there was an error creating a sessionid, making new sessionID');
//         sessionId = HostApi.createSession();
//       }
//       if (await sessionId == 'error finding sessionId') {
//         log('couldnt erite to nfc, as no sessionId could be found');
//         // TODO: create NoSessionIDFoundException
//         throw new NoSessionIDException();
//       } else {
//         if (_isNFCSupported) {
//           log("nfc is suppoted");
// //        var _stream =
//           await NFC
//               .writeNDEF(await _buildMessage(uid),
//               message: 'Activating your Fonz Coaster!', once: true)
//               .first;
//           wroteSuccessfully = true;
//           log("uid is: " + uid);
// //        log("uid is: " + uid);
//           // will addCoaster on the page
// //        await HostApi.addCoaster(uid);
//         } else {
//           log("nfc isnt suppoted");
//           throw new NfcNotSupportedException();
//         }
//         return wroteSuccessfully;
//       }
//     } on NfcNotSupportedException catch (e, stacktrace) {
//       await NfcNotSupportedException.report(stacktrace);
//       rethrow;
//     } on NoSessionIDException catch (e, stacktrace) {
//       await NoSessionIDException.report(stacktrace);
//       rethrow;
//     } catch (e, stacktrace) {
//       await GenericException.report(e, stacktrace);
//       rethrow;
//     }
//   }
//
//   static Future<NDEFMessage> _buildMessage(String uid) async {
//     List<NDEFRecord> _records = [];
//     NDEFRecord _name = new NDEFRecord.custom(
//         type: 'Name:', payload: FirebaseAuth.instance.currentUser.displayName);
//     _records.add(_name);
//     NDEFRecord _sessionId =
//     new NDEFRecord.custom(type: 'SessionID: ', payload: await sessionId);
//     _records.add(_sessionId);
//     NDEFRecord _uid = new NDEFRecord.custom(type: 'Uid: ', payload: uid);
//     _records.add(_uid);
//     return NDEFMessage.withRecords(_records);
//   }

  static Future<void> updateNFC() async {
    bool _isNdefSupported = await NFC.isNDEFSupported;
  }

  // scanns for and checks for the uid on android
  static Future<String> _scanForUidOnAndroid() async {
    String coasterUid;
    Stream<NDEFMessage> _stream;

    _stream = NFC.readNDEF(alertMessage: 'Looking for a Fonz!', once: true);
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
    // i believe this is proper way to retrieve the uid from the library.
    // check docs otherwise:
    //
    coasterUid = record.id;
    log("uid from id " + record.id.toString());
    log("getting caught here");
    return coasterUid;
  }
}