

import 'dart:developer';

import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestSpotifyApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/HostApi/CoasterManagementApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/HostApi/HostProvidersApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/HostApi/HostSpotifyApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

var hostSessionIdGlobal = "";
ActiveSongDecoder activeSongNowPlaying;
var updateActiveSong = true;

class CoreUserAttributes {
  bool _connectedToSpotify = false;
  bool _hasConnectedCoasters = false;
  bool _hasAccount = false;
  String _userSpotifyId = "spotify account";

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
    final spotifyIdFromStorage = localPreferences.getString("spotifyDisplayName");
    if (spotifyIdFromStorage != null) {
      _userSpotifyId = spotifyIdFromStorage;
    }
    log("spot is " + _connectedToSpotify.toString());
    log("coasters is " + _hasConnectedCoasters.toString());
    log("account is " + _hasAccount.toString());
  }

  bool getHasAccount() {
    return _hasAccount;
  }
  setHasAccount(bool boolie) async {
    this._hasAccount = boolie;
    // Create local preferences
    SharedPreferences localPreferences = await SharedPreferences.getInstance();
    // store in preferences
    localPreferences.setBool("_hasAccount", boolie);

  }

  bool getHasConnectedCoasters() {
    return _hasConnectedCoasters;
  }
  setHasConnectedCoasters(bool boolie) async {
    this._hasConnectedCoasters = boolie;
    // Create local preferences
    SharedPreferences localPreferences = await SharedPreferences.getInstance();
    // store in preferences
    localPreferences.setBool("_hasConnectedCoasters", boolie);
  }
  determineIfUserHasCoasters() async {
    // get music providers

    var coasters = await CoasterManagementApi.getOwnedCoasters();

    // checks how many providers & updates accordingly
    if (coasters["body"]["quantity"] > 0) {
      setHasConnectedCoasters(true);
    }
    else {
      setHasConnectedCoasters(false);
    }
  }

  bool getConnectedToSpotify() {
    return _connectedToSpotify;
  }
  setConnectedToSpotify(bool boolie) async {
    this._connectedToSpotify = boolie;
    // Create local preferences
    SharedPreferences localPreferences = await SharedPreferences.getInstance();
    // store in preferences
    localPreferences.setBool("_connectedToSpotify", boolie);
  }
  determineIfUserConnectedToSpotify() async {
    // get music providers

    var musicProviders = await HostProvidersApi.getMusicProviders();

    // checks how many providers & updates accordingly
    if (musicProviders["body"].length > 0 && musicProviders["body"][0]["providerId"] != "") {
      setConnectedToSpotify(true);
    }
    else {
      setConnectedToSpotify(false);
    }
  }

  String getSpotifyId() {
    return _userSpotifyId;
  }

}