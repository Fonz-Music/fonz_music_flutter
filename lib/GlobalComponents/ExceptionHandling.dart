// import 'dart:io';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:flutter/material.dart';
// import 'FrontEnd/FrontEndConstants.dart';
//
// abstract class FonzException implements Exception {
//   final String message = "";
//   static Future<void> report() {}
// }
//
// Future<void> setCrashlyticsInfo() async {
//   await FirebaseCrashlytics.instance
//       .setCustomKey('OS', Platform.operatingSystem);
//   await FirebaseCrashlytics.instance
//       .setCustomKey('OS_Version', Platform.operatingSystemVersion);
//   // await FirebaseCrashlytics.instance
//   //     .setUserIdentifier(FirebaseAuth.instance.currentUser.uid);
// }
//
// class GenericException implements FonzException {
//   final String message = "Unknown Exception has Occured";
//   final Exception e;
//   const GenericException(this.e);
//   @override
//   static Future<void> report(Exception e, StackTrace stacktrace) async {
//     await setCrashlyticsInfo();
//     await FirebaseCrashlytics.instance.recordError(
//         GenericException(e), stacktrace,
//         reason: "Unknown exception occured");
//   }
// }
//
// class HostNotPlayingException implements FonzException {
//   const HostNotPlayingException();
//   final String message = "Check that the host is already playing music";
//   static Future<void> report(String hostId, StackTrace stacktrace) async {
//     await setCrashlyticsInfo();
//     await FirebaseCrashlytics.instance.recordError(
//         HostNotPlayingException(), stacktrace,
//         reason: "Host is not currently playing HostID: " + hostId);
//   }
// }
//
// class ErrorOnTapException implements FonzException {
//   const ErrorOnTapException();
//   final String message = "Error with the tap";
//   @override
//   static Future<void> report(StackTrace stacktrace) async {
//     await setCrashlyticsInfo();
//     await FirebaseCrashlytics.instance.recordError(
//         ErrorOnTapException(), stacktrace,
//         reason: "error with tap");
//   }
// }
//
// class NfcNotSupportedException implements FonzException {
//   const NfcNotSupportedException();
//   final message = "Device does not support NFC";
//   @override
//   static Future<void> report(StackTrace stacktrace) async {
//     await setCrashlyticsInfo();
//     await FirebaseCrashlytics.instance.recordError(
//         NfcNotSupportedException(), stacktrace,
//         reason: 'device does not support NFC');
//   }
// }
//
// class NotFonzException implements FonzException {
//   const NotFonzException();
//   final String message = "Scanned tag is not a Fonz coaster";
//   @override
//   static Future<void> report(StackTrace stacktrace) async {
//     await setCrashlyticsInfo();
//     await FirebaseCrashlytics.instance.recordError(
//         NotFonzException(), stacktrace,
//         reason: "scanned tag not fonz");
//   }
// }
//
// class NoHostException implements FonzException {
//   final String message = "No current host";
//   const NoHostException();
//   @override
//   static Future<void> report(StackTrace stacktrace) async {
//     await setCrashlyticsInfo();
//     await FirebaseCrashlytics.instance.recordError(
//         NoHostException(), stacktrace,
//         reason: "no current host for user");
//   }
// }
//
// class SearchIssueException implements FonzException {
//   final String term;
//   final String message = "Issue with search";
//   const SearchIssueException(this.term);
//   @override
//   static Future<void> report(String term, StackTrace stacktrace) async {
//     await setCrashlyticsInfo();
//     await FirebaseCrashlytics.instance.setCustomKey('term', term);
//     await FirebaseCrashlytics.instance.recordError(
//         SearchIssueException(term), stacktrace,
//         reason: "issue on search");
//   }
// }
//
// class SessionNotJoinedException implements FonzException {
//   final String message = "Session Could Not Be Joined";
//   const SessionNotJoinedException();
//   @override
//   static Future<void> report(StackTrace stacktrace) async {
//     await setCrashlyticsInfo();
//     await FirebaseCrashlytics.instance.recordError(
//         SessionNotJoinedException(), stacktrace,
//         reason: "session could not be joined");
//   }
// }
//
// class SessionIDCreationException implements FonzException {
//   final String message = "Error creating sessionId";
//   const SessionIDCreationException();
//   @override
//   static Future<void> report(StackTrace stacktrace) async {
//     await setCrashlyticsInfo();
//     await FirebaseCrashlytics.instance.recordError(
//         SessionIDCreationException(), stacktrace,
//         reason: "error creating sessionId");
//   }
// }
//
// class NoSessionIDException implements FonzException {
//   final String message = "No sessionId found";
//   const NoSessionIDException();
//   @override
//   static Future<void> report(StackTrace stacktrace) async {
//     await setCrashlyticsInfo();
//     await FirebaseCrashlytics.instance.recordError(
//         NoSessionIDException(), stacktrace,
//         reason: "no sessionId found");
//   }
// }
//
// // Add more enums for exception types for spotify
// enum SpotifyExceptionTypes {
//   ARTISTS,
//   TRACKS,
// }
//
// // Helper class for Spotify issues when querying directly
// class SpotifyException implements FonzException {
//   String message = 'Failed to fetch personalized Spotify info for user';
//   SpotifyExceptionTypes type;
//   SpotifyException(SpotifyExceptionTypes type) {
//     this.type = type;
//     if (type == SpotifyExceptionTypes.ARTISTS) {
//       this.message = 'Failed trying to fetch personalized artists for user';
//     } else if (type == SpotifyExceptionTypes.TRACKS) {
//       this.message = 'Failed to fetch personalizes tracks for user';
//     }
//   }
// }
//
// AssetImage errorImage(FonzException exception) {
//   try {
//     throw exception;
//   } on NoHostException {
//     if (darkMode) {
//       return new AssetImage("assets/darkGreyIcons/coasterIconDarkGrey.png");
//     } else {
//       return new AssetImage("assets/lightGreyIcons/coasterIconLightGrey.png");
//     }
//   } on NotFonzException {
//     if (darkMode) {
//       return new AssetImage("assets/darkGreyIcons/coasterIconDarkGrey.png");
//     } else {
//       return new AssetImage("assets/lightGreyIcons/coasterIconLightGrey.png");
//     }
//   } on ErrorOnTapException {
//     if (darkMode) {
//       return new AssetImage("assets/darkGreyIcons/coasterIconDarkGrey.png");
//     } else {
//       return new AssetImage("assets/lightGreyIcons/coasterIconLightGrey.png");
//     }
//   } on NfcNotSupportedException {
//     if (darkMode) {
//       return new AssetImage("assets/darkGreyIcons/coasterIconDarkGrey.png");
//     } else {
//       return new AssetImage("assets/lightGreyIcons/coasterIconLightGrey.png");
//     }
//   } on HostNotPlayingException {
//     if (darkMode) {
//       return new AssetImage("assets/darkGreyIcons/rockOnIconDarkGrey.png");
//     } else {
//       return new AssetImage("assets/lightGreyIcons/rockOnIconLightGrey.png");
//     }
//   } on FonzException {
//     if (darkMode) {
//       return new AssetImage("assets/darkGreyIcons/coasterIconDarkGrey.png");
//     } else {
//       return new AssetImage("assets/lightGreyIcons/coasterIconLightGrey.png");
//     }
//   }
// }
//
// String errorMessage(FonzException exception) {
//   return exception.message;
// }
