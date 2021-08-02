import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fonz_music_flutter/ApiFunctions/AuthMethods.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiConstants.dart';

class UserApi {
  // sign in user
  static Future<Map> updateUserAccount(String email, String password, String displayName, bool agreedConsent, bool agreedMarketing) async {
    String endpoint = address + user;
    // fetch token
    String token = await getJWTAndCheckIfExpired();
    // dio
    Dio dio = new Dio();
    // add auth token
    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    try {
// execute endpoint
      var response = await dio.put(endpoint, data: {email: email, password: password});
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        // to return data
        final updateUserDecoded = UpdateAccountDecoder.fromJson(response.data);
        response.data = updateUserDecoded;
        // Create local preferences
        SharedPreferences localPreferences = await SharedPreferences.getInstance();
        // store email
        localPreferences.setString("userEmail", updateUserDecoded.email);
        // store displayName
        localPreferences.setString("userDisplayName", updateUserDecoded.displayName);


      }
      log("status code of update account is " + response.statusCode.toString());
      return {"statusCode": response.statusCode, "code": response.statusMessage,
        "body": response.data};
    }
    on DioError catch (e) {
      return {
        "statusCode": e.response.data["status"],
        "code": e.response.data["code"],
        "body": e.response.data["message"]
      };
    }



  }
}


// update account decoder
class UpdateAccountDecoder {
  String displayName;
  String userId;
  String email;


  UpdateAccountDecoder({this.displayName, this.userId, this.email});

  UpdateAccountDecoder.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
  userId = json['userId'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['displayName'] = this.displayName;
  data['userId'] = this.userId;
  data['email'] = this.email;
  return data;
  }
  }