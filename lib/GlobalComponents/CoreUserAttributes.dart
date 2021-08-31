//
//
// import 'dart:developer';
//
// import 'package:fonz_music_flutter/ApiFunctions/UserEndpoints/UserApi.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
//
// class CoreUserAttributes {
//   bool _connectedToSpotify = false;
//   bool _hasAccount = false;
//
//   String _userId = "";
//   String _userDisplayName = "";
//
//
//   // bool throwCreateAccountPopup = false;
//
//   setAttributes() async {
//     log("setting attributes");
//     // Create local preferences
//     SharedPreferences localPreferences = await SharedPreferences.getInstance();
//     final spotifyBoolFromStorage = localPreferences.getBool("_connectedToSpotify");
//     if (spotifyBoolFromStorage != null) {
//       _connectedToSpotify = spotifyBoolFromStorage;
//     }
//     final accountBoolFromStorage = localPreferences.getBool("_hasAccount");
//     if (accountBoolFromStorage != null) {
//       _hasAccount = accountBoolFromStorage;
//     }
//
//     final userIdFromStorage = localPreferences.getString("userId");
//     if (userIdFromStorage != null) {
//       _userId = userIdFromStorage;
//     }
//
//     final userDisplayNameFromStorage = localPreferences.getString("userDisplayName");
//     if (userDisplayNameFromStorage != null) {
//       _userDisplayName = userDisplayNameFromStorage;
//     }
//
//     log("spot is " + _connectedToSpotify.toString());
//     log("account is " + _hasAccount.toString());
//   }
//
//   determineAllUserAttributesAfterSignIn() async {
//     await UserApi.getUserAccount();
//
//     await setAttributes();
//   }
//
//   deleteAttributesAfterSignOut() async {
//     await setHasAccount(false);
//
//     await setUserDisplayName("");
//     await setUserId("");
//
//
//
//
//   }
//
//   bool getHasAccount() {
//     return _hasAccount;
//   }
//   setHasAccount(bool boolie) async {
//     this._hasAccount = boolie;
//     // Create local preferences
//     SharedPreferences localPreferences = await SharedPreferences.getInstance();
//     // store in preferences
//     localPreferences.setBool("_hasAccount", boolie);
//
//   }
//
//
//   // user id
//   String getUserId() {
//     return _userId;
//   }
//   setUserId(String newId) async {
//     this._userId = newId;
//     // Create local preferences
//     SharedPreferences localPreferences = await SharedPreferences.getInstance();
//     // store in preferences
//     localPreferences.setString("userId", newId);
//
//   }
//
//   // user display name
//   String getUserDisplayName() {
//     return _userDisplayName;
//   }
//   setUserDisplayName(String newName) async {
//     this._userDisplayName = newName;
//     // Create local preferences
//     SharedPreferences localPreferences = await SharedPreferences.getInstance();
//     // store in preferences
//     localPreferences.setString("userDisplayName", newName);
//
//   }
//
//
// }