

import 'dart:developer';

import 'package:fonz_music_flutter/ApiFunctions/HostApi/HostProvidersApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifySignInEndpoints/SpotifySignInApi.dart';
import 'package:url_launcher/url_launcher.dart';

connectSpotify() async {
  log("connecting spot");
  // fetch spotify sign in url
  var url = await SpotifySignInApi.getSpotifyAuthUrl();
  var providers = await HostProvidersApi.getMusicProviders();
  print(providers["body"].toString());
  log("url is " + url);
  // // can use launch url
  // if (await canLaunch(url))
  //   // if so, launch
  //   await launch(url);
  // else
  //   // can't launch url, there is some error
  //   throw "Could not launch $url";
}