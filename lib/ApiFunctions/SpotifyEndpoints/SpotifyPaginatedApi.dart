import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fonz_music_flutter/ApiFunctions/UserTopArtistsResponse.dart';
import 'package:fonz_music_flutter/ApiFunctions/UserTopTracksResponse.dart';
import 'package:fonz_music_flutter/GlobalComponents/ExceptionHandling.dart';
import '../ApiConstants.dart';
import '../AuthMethods.dart';

class SpotifyPaginatedApi {
  static Future<Map> sessionSearchPaginated(String sessionId, String term, int offset) async {
    // log("Session id " + sessionId);

    var offsetString = "&offset=" + offset.toString() + "&limit=20";
    String endpoint =
        address + guest + sessionId + '/' + spotify + searchTerm + term + offsetString;
    log(endpoint);
    // fetch token
    String token = await getJWTAndCheckIfExpired();
    // await FirebaseAuth.instance.currentUser.getIdToken();

    // dio
    Dio dio = new Dio();
    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    log("about to get resp inside paginated search");
    try {
      var response = await dio.get(endpoint);
      log(response.data.toString());
      log("success");
      return {
        "statusCode": response.statusCode,
        "message":
        // response.body};
        response.statusMessage,
        "body": response.data
      };
    } on DioError catch (e) {
      log("issue " + e.response.data);
      log("dailure");
      return {
        "statusCode": e.response.data["status"],
        "code": e.response.data["code"],
        "body": e.response.data["body"]
      };
    }
  }

}