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

    // dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    var response = await dio.get(endpoint);
    log("dio works");
    var returnVersion;
    //http
    // var response = await http.get(endpoint,
    //     headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    if (response.statusCode == 200) {
//      log('success got coasters');
      log("success");
      returnVersion = response.data["minimumAppVersion"];
      log("type is " + returnVersion.runtimeType.toString());
    } else {

      // FlutterCrashlytics().log(
      //     'error on "getOwnedCoasters" api call with status of ${response.statusCode} & body of'
      //         ' ${response.data}');
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
}