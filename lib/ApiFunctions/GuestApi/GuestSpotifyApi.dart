import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

import '../ApiConstants.dart';
// import 'package:http/http.dart' as http;



class GuestSpotifyApi {

  // --------------------------------------------now dio---------------------------------------------------------

  static Future<Map> sessionSearch(
      String sessionId, String term) async {
    log("Session id " + sessionId);
    String endpoint =
        address + guest + sessionId + '/' + spotify + searchTerm + term;
    log(endpoint);
    String token = "";
    // await FirebaseAuth.instance.currentUser.getIdToken();

    // dio
    Dio dio = new Dio();
    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    log("about to get resp inside sessopnSearch");
    try {
      var response = await dio.get(endpoint);
      log(response.data.toString());
      log("success");
      return {"responseCode": response.statusCode, "message":
      // response.body};
      response.statusMessage, "body": response.data};
    }
    on DioError catch (e) {
      log("issue " + e.response.data);
      log("dailure");
      return {"responseCode": e.response.statusCode, "message":
      e.response.statusMessage, "body": e.response.data};
    }
  }


  // --------------------------------------------now dio---------------------------------------------------------

  static Future<Map> queueTrackSpotify(
      String trackId, String sessionId) async {
    var token = "";
    // await FirebaseAuth.instance.currentUser.getIdToken();
    var endpoint = address +
        guest +
        sessionId +
        '/' +
        spotify +
        queue +
        'spotify:track:$trackId';
    log(endpoint);
    var returnToUser;
//    dio
    Dio dio = new Dio();
    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    try {
      var response = await dio.post(endpoint);
      // http
      // return await http.post(endpoint, headers: {
      //   HttpHeaders.authorizationHeader: "Bearer $token",
      // });
      if (response.statusCode == 200) {
        log("success");
        return {"responseCode": response.statusCode, "message":
        response.statusMessage, "body": response.data};
      }
      else {
        log("not 200");
        return {"responseCode": response.statusCode, "message":
        response.statusMessage, "body": response.data};
      }
    }
    on DioError catch (e) {
      return {"responseCode": e.response.statusCode, "message":
      e.response.statusMessage, "body": e.response.data};
    }


    return returnToUser;
  }
}