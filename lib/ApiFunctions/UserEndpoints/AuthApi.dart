import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../ApiConstants.dart';

class AuthApi {

  // create anon account
  static Future<Map> createAnonAccount() async {
    String endpoint = address + auth + register + "anonymous";
    // dio
    Dio dio = new Dio();
    try {
      var response = await dio.post(endpoint);
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        // to return data
        final createAnonDecoded = CreateAnonAccountDecoder.fromJson(response.data);
        response.data = createAnonDecoded;
        // Create storage
        final storage = new FlutterSecureStorage();
        // store accessToken
        await storage.write(key: "accessToken", value: createAnonDecoded.accessToken);
        // store refreshToken
        await storage.write(key: "refreshToken", value: createAnonDecoded.refreshToken);
      }
      log("status code of create Anon account is " + response.statusCode.toString());
      return {"statusCode": response.statusCode, "code": response.statusMessage,
        "body": response.data};
    }
    on DioError catch (e) {
      log("issue " + e.response.data.toString());
      log("dailure");
      log("issue " + e.response.data["message"]);
      return {
        "statusCode": e.response.data["status"],
        "code": e.response.data["code"],
        "body": e.response.data["message"]
      };
    }


  }

  // sign in user
  static Future<Map> signInUser(String email, String password) async {
    String endpoint = address + auth + "login";
    // dio
    Dio dio = new Dio();
    try {
      var response = await dio.post(endpoint, data: {"email": email, "password": password});
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        // to return data
        final signInDecoded = SignInUserDecoder.fromJson(response.data);
        response.data = signInDecoded;
        // Create storage
        final storage = new FlutterSecureStorage();
        // store accessToken
        await storage.write(key: "accessToken", value: signInDecoded.accessToken);
        // store refreshToken
        await storage.write(key: "refreshToken", value: signInDecoded.refreshToken);
      }
      log("status code of sign in is " + response.statusCode.toString());
      return {"statusCode": response.statusCode, "code": response.statusMessage,
        "body": response.data};
    }
    on DioError catch (e) {
      log("status code " +e.response.data["statusCode"].toString());
      log("status code " +e.response.toString());
      return {
        "statusCode": e.response.data["status"],
        "code": e.response.data["code"],
        "body": e.response.data["message"]
      };
    }


  }

  // register user, should NOT be used
  static Future<Map> registerUser(String email, String password) async {
    String endpoint = address + auth + "register";
    // dio
    Dio dio = new Dio();
    try {
      var response = await dio.post(endpoint, data: {"email": email, "password": password});
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        // to return data
        final signInDecoded = SignInUserDecoder.fromJson(response.data);
        response.data = signInDecoded;
        // Create storage
        final storage = new FlutterSecureStorage();
        // store accessToken
        await storage.write(key: "accessToken", value: signInDecoded.accessToken);
        // store refreshToken
        await storage.write(key: "refreshToken", value: signInDecoded.refreshToken);
      }
      log("status code of register account is " + response.statusCode.toString());
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

  // register user, should NOT be used
  static Future<Map> refreshAccessToken(String userId, String refreshToken) async {
    String endpoint = address + auth + "refresh";
    // dio
    Dio dio = new Dio();

    try {
      var response = await dio.post(endpoint, data: {"userId": userId, "refreshToken": refreshToken});
      log(response.statusCode.toString());
      log("data is " + response.data.toString());
      if (response.statusCode == 200) {
        // to return data
        final signInDecoded = SignInUserDecoder.fromJson(response.data);
        response.data = signInDecoded;
        log("data is " + response.data.toString());
        // Create storage
        final storage = new FlutterSecureStorage();
        // store accessToken
        await storage.write(key: "accessToken", value: signInDecoded.accessToken);

      }
      log("status code of register account is " + response.statusCode.toString());
      return {"statusCode": response.statusCode, "code": response.statusMessage,
        "body": response.data};
    }
    on DioError catch (e) {
      log("status code " +e.response.toString());
      log("status code " +e.response.data["status"].toString());

      return {
        "statusCode": e.response.data["status"],
        "code": e.response.data["code"],
        "body": e.response.data["message"]
      };
    }


  }

}


// create anon account decoder
class CreateAnonAccountDecoder {
  String accessToken;
  String userId;
  String refreshToken;

  CreateAnonAccountDecoder({this.accessToken, this.userId, this.refreshToken});

  CreateAnonAccountDecoder.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    userId = json['userId'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['userId'] = this.userId;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}


// create anon account decoder
class SignInUserDecoder {
  String accessToken;
  String refreshToken;

  SignInUserDecoder({this.accessToken, this.refreshToken});

  SignInUserDecoder.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}
