import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fonz_music_flutter/ApiFunctions/UserTopArtistsResponse.dart';
import 'package:fonz_music_flutter/ApiFunctions/UserTopTracksResponse.dart';
import 'package:fonz_music_flutter/GlobalComponents/ExceptionHandling.dart';
import '../ApiConstants.dart';
// import 'package:http/http.dart' as http;

// TODO: remove this when spotify integration complete
String token =
    'BQC8xt_VTy69SLUEX56X0mLzK-mtcNYbpVRLpj6yFGrcfTxAuST8FsOf7Xz0pDTJIdWreUNnJjL0CbR4lqwFaMFpND4hHpk1J_jrICRUaJ7mcpMQWM3wkyhMW0E76ef25Wt_mTjr8LvUeacA91IxawHnkMC4oDqf1JUozauZD8ADYpy8UjHIGTl2IrRgP6x7OuVOdES81YFIMq2ZtQVNGr45dKch8GOS8cp_QnG_vv1Vj4JN9pJIqlGfsX4oD2q3v693h6LTCfhQUFbBWRhmua_aOMSAxhW1a1BU2R3JHeKy';

class GuestSpotifyApi {
  // --------------------------------------------now dio---------------------------------------------------------

  static Future<Map> sessionSearch(String sessionId, String term) async {
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
      return {
        "responseCode": response.statusCode,
        "message":
            // response.body};
            response.statusMessage,
        "body": response.data
      };
    } on DioError catch (e) {
      log("issue " + e.response.data);
      log("dailure");
      return {
        "responseCode": e.response.statusCode,
        "message": e.response.statusMessage,
        "body": e.response.data
      };
    }
  }

  // --------------------------------------------now dio---------------------------------------------------------

  static Future<Map> queueTrackSpotify(String trackId, String sessionId) async {
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
        return {
          "responseCode": response.statusCode,
          "message": response.statusMessage,
          "body": response.data
        };
      } else {
        log("not 200");
        return {
          "responseCode": response.statusCode,
          "message": response.statusMessage,
          "body": response.data
        };
      }
    } on DioError catch (e) {
      return {
        "responseCode": e.response.statusCode,
        "message": e.response.statusMessage,
        "body": e.response.data
      };
    }

    return returnToUser;
  }

  static Future<UserTopArtistsResponse> getUserTopArtists() async {
    Dio dio = new Dio();
    try {
      dio.options.headers = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
      Response response =
          await dio.get('https://api.spotify.com/v1/me/top/artists');
      if (response.statusCode == 200) {
        UserTopArtistsResponse.fromJson(json.decode(response.data.toString()));
      } else {
        log(response.statusCode.toString());
        log(response.statusMessage);
        log(response.data.toString());
        throw new SpotifyException(SpotifyExceptionTypes.ARTISTS);
      }
    } on SpotifyException catch (e) {
      rethrow;
    }
  }

  static Future<UserTopTracksResponse> getUserTopTracks() async {
    Dio dio = new Dio();
    dio.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    try {
      Response response =
          await dio.get('https://api.spotify.com/v1/me/top/tracks');
      if (response.statusCode == 200) {
        UserTopTracksResponse.fromJson(json.decode(response.data.toString()));
      } else {
        log(response.statusCode.toString());
        log(response.statusMessage);
        log(response.data.toString());
        throw new SpotifyException(SpotifyExceptionTypes.TRACKS);
      }
    } on SpotifyException catch (e) {
      rethrow;
    }
  }
}
