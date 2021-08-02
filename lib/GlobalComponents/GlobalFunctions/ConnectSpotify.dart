

import 'dart:developer';

import 'package:fonz_music_flutter/ApiFunctions/HostApi/HostProvidersApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/HostApi/HostSessionsApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifySignInEndpoints/SpotifySignInApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

connectSpotify() async {
  log("connecting spot");
  // fetch spotify sign in url
  var url = await SpotifySignInApi.getSpotifyAuthUrl();
  
  log("url is " + url);
  // // can use launch url
  // if (await canLaunch(url))
  //   // if so, launch
  //   await launch(url);
  // else
  //   // can't launch url, there is some error
  //   throw "Could not launch $url";
  
  // on return
  // fetch all sessions, stores sessionId from session #0 or
  // creates a new one
  var sessions = await HostSessionsApi.getAllSessions();
  // fetch all providers
  var providers = await HostProvidersApi.getMusicProviders();
  log(providers["body"].toString());
  // sets providerId
  final providerId = providers["body"][0]["providerId"];
  // sessionId stored in local storage
  SharedPreferences localPreferences = await SharedPreferences.getInstance();
  // sets sessionId
  final sessionId = await localPreferences.getString("userAccountSessionId");
  log("sessionId is " + sessionId);
  var updateSessionWithProviderId = await HostSessionsApi.updateSessionWithProviderId(sessionId, providerId);
  log("status code of updating is " + updateSessionWithProviderId["statusCode"].toString());
}