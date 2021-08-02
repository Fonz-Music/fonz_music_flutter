import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiConstants.dart';
import '../AuthMethods.dart';

class SpotifySignInApi {

  // gets Spotify url for sign in
  static Future<String> getSpotifyAuthUrl() async {
    String endpoint = address + providers + spotify + "?device=Android";
    String token = await getJWTAndCheckIfExpired();
    log("endpoint: " + endpoint);
    String urlReturn;
    // dio
    Dio dio = new Dio();
    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    try {
      var response = await dio.get(endpoint);
      if (response.statusCode == 200) {
        log("resp is " + response.data.toString());
        // convert return data to createSessionDecoder
        final getSpotifyUrlDecoder = GetSpotifyUrlDecoder.fromJson(response.data);
        // return url
        urlReturn = getSpotifyUrlDecoder.authorizeURL;
      }
      return urlReturn;
    }
    on DioError catch (e) {
      return urlReturn;
    }
  }
}


class GetSpotifyUrlDecoder {
  var authorizeURL;

  GetSpotifyUrlDecoder({this.authorizeURL});

  GetSpotifyUrlDecoder.fromJson(Map<String, dynamic> json) {
    authorizeURL = json['authorizeURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authorizeURL'] = this.authorizeURL;
    return data;
  }
}