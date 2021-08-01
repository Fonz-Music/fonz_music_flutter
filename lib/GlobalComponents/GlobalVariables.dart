

import 'dart:developer';

import 'package:fonz_music_flutter/ApiFunctions/HostApi/HostSpotifyApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

var hostSessionIdGlobal = "";

class CoreUserAttributes {
  bool _connectedToSpotify = false;
  bool _hasConnectedCoasters = false;
  bool _hasAccount = false;

  setAttributes() async {
    log("setting attributes");
    // Create local preferences
    SharedPreferences localPreferences = await SharedPreferences.getInstance();
    _connectedToSpotify = localPreferences.getBool("_connectedToSpotify");
    _hasConnectedCoasters = localPreferences.getBool("_hasConnectedCoasters");
    _hasAccount = localPreferences.getBool("_hasAccount");
  }

  bool getHasAccount() {
    return _hasAccount;
  }
  setHasAccount(bool bool) async {

    _hasAccount = bool;
    // Create local preferences
    SharedPreferences localPreferences = await SharedPreferences.getInstance();
    // store in preferences
    localPreferences.setBool("_hasAccount", bool);

  }

  bool getHasConnectedCoasters() {
    return _hasConnectedCoasters;
  }
  setHasConnectedCoasters(bool bool) async {
    _hasConnectedCoasters = bool;
    // Create local preferences
    SharedPreferences localPreferences = await SharedPreferences.getInstance();
    // store in preferences
    localPreferences.setBool("_hasConnectedCoasters", bool);
  }

  bool getConnectedToSpotify() {
    return _connectedToSpotify;
  }
  setConnectedToSpotify(bool bool) async {
    _connectedToSpotify = bool;
    // Create local preferences
    SharedPreferences localPreferences = await SharedPreferences.getInstance();
    // store in preferences
    localPreferences.setBool("_connectedToSpotify", bool);
  }
  determineIfUserConnectedToSpotify() {
    // get music providers
    // var musicProviders = HostSpotifyApi()

    // checks how many providers & updates accordingly
    // if (musicProviders.count > 0 && musicProviders[0].providerId != "") {
    //   setConnectedToSpotify(true);
    // }
    // else {
    //   setConnectedToSpotify(false);
    // }
  }


}