

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
    final spotifyBoolFromStorage = localPreferences.getBool("_connectedToSpotify");
    if (spotifyBoolFromStorage != null) {
      _connectedToSpotify = spotifyBoolFromStorage;
    }
    final coastersBoolFromStorage = localPreferences.getBool("_hasConnectedCoasters");
    if (coastersBoolFromStorage != null) {
      _hasConnectedCoasters = coastersBoolFromStorage;
    }
    final accountBoolFromStorage = localPreferences.getBool("_hasAccount");
    if (accountBoolFromStorage != null) {
      _hasAccount = accountBoolFromStorage;
    }
    log("spot is " + _connectedToSpotify.toString());
    log("coasters is " + _hasConnectedCoasters.toString());
    log("account is " + _hasAccount.toString());
  }

  bool getHasAccount() {
    return _hasAccount;
  }
  setHasAccount(bool bool) async {

    log("changing has acc to " + bool.toString());
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
    log("changing has coaster to " + bool.toString());
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
    log("changing has spot to " + bool.toString());
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