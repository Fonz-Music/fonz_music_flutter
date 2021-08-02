import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestGetCoasterApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiConstants.dart';
import '../AuthMethods.dart';

class HostProvidersApi {
  static Future<Map> getMusicProviders() async {
    String endpoint = address + providers;
    String token = await getJWTAndCheckIfExpired();
    log("endpoint: " + endpoint);

    // dio
    Dio dio = new Dio();
    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    try {
      var response = await dio.get(endpoint);
      if (response.statusCode == 200) {
        log("resp is " + response.data.toString());
        List providersResponse = response.data;

        response.data = providersResponse;
        log("providers length " + providersResponse.length.toString());
        // check if there aren't sessions
        if (providersResponse.length > 0 ) {
          // store sessionId in local storage
          SharedPreferences localPreferences = await SharedPreferences.getInstance();
          // store in preferences
          localPreferences.setString("spotifyDisplayName", providersResponse[0]["displayName"]);

          log("storing this display name " + providersResponse[0]["displayName"].toString());

        }
        else {
          log("no providers");
        }
      } else {
        log("error ");
        log('error with response code ${response.statusCode} and body '
        // ' ${response.body}');
            ' ${response.data}');
        return null;
      }
      // log("response message " + response.statusMessage);
      // log("response code " + response.statusCode.toString());
      return {"statusCode": response.statusCode, "code": response.statusMessage,
        "body": response.data};
    }
    on DioError catch (e) {
      // log("this is msg " + e.response.statusMessage.toString());
      // log("this is status " + e.response.statusCode.toString());
      //
      // log("this is mssg" + e.response.data["message"].toString());
      // print("this is mssg" + e.response.data["code"].toString());
      return {
        "statusCode": e.response.data["status"],
        "code": e.response.data["code"],
        "body": e.response.data["message"]
      };
    }

  }
}

class ProviderDecoder {

  String provider;
  String providerId;
  String displayName;
  String userId;

  ProviderDecoder({
    this.provider,
    this.providerId,
    this.displayName,
    this.userId});

  ProviderDecoder.fromJson(Map<String, dynamic> json) {
    providerId = json['providerId'];
    provider = json['provider'];
    displayName = json['displayName'];
    userId = json['userId'];
  }
}
