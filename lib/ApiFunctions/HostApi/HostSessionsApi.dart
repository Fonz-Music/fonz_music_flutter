import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestGetCoasterApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiConstants.dart';
import '../AuthMethods.dart';

class HostSessionsApi {
  static Future<Map> getAllSessions() async {
    log("im getting called ");
    String endpoint = address + host + session;
    String token = await getJWTAndCheckIfExpired();
    // await FirebaseAuth.instance.currentUser.getIdToken();
    log("endpoint: " + endpoint);

    // dio
    Dio dio = new Dio();

    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};

    log("dio works");
    try {
      var response = await dio.get(endpoint);
      if (response.statusCode == 200) {
//      log('success got coasters');
        log("success");
        log("resp is " + response.data.toString());
        List sessionsResponse = response.data;
        response.data = sessionsResponse;
        log("sessions length " + sessionsResponse.length.toString());
        // check if there aren't sessions
        if (sessionsResponse.length == 0 ) {
          // create session if there are none
          await createSession();
        }
        else {
          // store sessionId in local storage
          SharedPreferences localPreferences = await SharedPreferences.getInstance();
          // store in preferences
          localPreferences.setString("userAccountSessionId", sessionsResponse[0]["sessionId"]);

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

  static Future<Map> getSession(String sessionId) async {
    log("im getting called ");
    String endpoint = address + host + session + sessionId;
    String token = await getJWTAndCheckIfExpired();
    // await FirebaseAuth.instance.currentUser.getIdToken();
    log("endpoint: " + endpoint);

    // dio
    Dio dio = new Dio();

    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};

    log("dio works");
    try {
      var response = await dio.get(endpoint);
      if (response.statusCode == 200) {
//      log('success got coasters');
        log("success");
        log("resp is " + response.data.toString());
        // convert return data to createSessionDecoder
        final getSessionDecoder = SessionDecoder.fromJson(response.data);
        // return session info
        response.data = getSessionDecoder;
        // store sessionId in local storage
        SharedPreferences localPreferences = await SharedPreferences.getInstance();
        // store in preferences
        localPreferences.setString("userAccountSessionId", getSessionDecoder.sessionId);

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

  static Future<Map> createSession() async {
    log("im getting called ");
    String endpoint = address + host + session;
    String token = await getJWTAndCheckIfExpired();
    // await FirebaseAuth.instance.currentUser.getIdToken();
    log("endpoint: " + endpoint);

    // dio
    Dio dio = new Dio();

    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};

    log("dio works");
    try {
      var response = await dio.post(endpoint);
      if (response.statusCode == 200) {
//      log('success got coasters');
        log("success");
        log("resp is " + response.data.toString());
        // convert return data to createSessionDecoder
        final createSessionDecoder = CreateSessionDecoder.fromJson(response.data);
        // return session info
        response.data = createSessionDecoder;
        // store sessionId in local storage
        SharedPreferences localPreferences = await SharedPreferences.getInstance();
        // store in preferences
        localPreferences.setString("userAccountSessionId", createSessionDecoder.sessionId);

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
  static Future<Map> updateSessionWithProviderId(String sessionId, String providerId) async {
    String endpoint = address + host + session + sessionId;
    String token = await getJWTAndCheckIfExpired();
    log("endpoint: " + endpoint);

    // dio
    Dio dio = new Dio();
    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    try {
      var response = await dio.put(endpoint, data: {"providerId": providerId, "active": true});
      if (response.statusCode == 200) {
        log("success");
      } else {
        log("error ");
        log('error with response code ${response.statusCode} and body '
        // ' ${response.body}');
            ' ${response.data}');
        return null;
      }
      log("response message " + response.statusMessage);
      log("response code " + response.statusCode.toString());
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


class GetAllSessionsDecoder {
  var sessions;

  GetAllSessionsDecoder({this.sessions});

  GetAllSessionsDecoder.fromJson(Map<String, dynamic> json) {
    sessions = json['sessions'];

    sessions = SessionDecoder.fromJson(json['session']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sessions'] = this.sessions;
    return data;
  }
}


class CreateSessionDecoder {
  bool active;
  String sessionId;
  String userId;

  CreateSessionDecoder({this.active, this.sessionId, this.userId});

  CreateSessionDecoder.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    sessionId = json['sessionId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['sessionId'] = this.sessionId;
    data['userId'] = this.userId;
    return data;
  }
}
