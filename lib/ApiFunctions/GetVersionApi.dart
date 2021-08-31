import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:fonz_music_flutter/GlobalComponents/ExceptionHandling.dart';

import 'ApiConstants.dart';

class GetVersionApi {
  static Future<String> sendVersion(String device) async {
    log("im getting called ");
    String endpoint = address + "version/" + "?device=" + device;
    // String token = await FirebaseAuth.instance.currentUser.getIdToken();
    log("endpoint: " + endpoint);

    // dio
    Dio dio = new Dio();
    try {
      var response = await dio.get(endpoint);
      log("dio works");
      var returnVersion;
      if (response.statusCode == 200) {
        log("success");
        returnVersion = response.data["minimumAppVersion"];
        log("type is " + returnVersion.runtimeType.toString());
      } else {
        log("error ");
        log('error with response code ${response.statusCode} and body '
        // ' ${response.body}');
            ' ${response.data}');
        return null;
      }
      log("response message " + response.statusMessage);
      log("response data " + response.data.toString());
      log("response code " + response.statusCode.toString());
      return returnVersion;
    }
    on DioError catch (e) {
      // log("this is msg " + e.response.statusMessage.toString());
      // log("this is status " + e.response.statusCode.toString());
      //
      // log("this is mssg" + e.response.data["message"].toString());
      // print("this is mssg" + e.response.data["code"].toString());
      return "NO_INTERNET";
    }

  }
}