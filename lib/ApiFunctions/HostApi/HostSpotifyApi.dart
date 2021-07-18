import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

import '../ApiConstants.dart';

class HostSpotifyApi {

//
//   // This may be useless
//   static Future<String> addProviderToAccount(String _provider) async {
//     String endpoint = address + auth + _provider;
//     // String token = await FirebaseAuth.instance.currentUser.getIdToken();
//
//     // dio
//    Dio dio = new Dio();
//    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
//    var response = await dio.get(endpoint);
//     //http
//     // var response = await http.get(endpoint,
//     //     headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
//     if (response.statusCode == 200) {
//       log('added privider to account');
//       return GetSessionIdDecoder.fromJson(json.decode(response.body)).sessionId;
// //          .fromJson(json.decode(response.data)).sessionId;
//     } else {
//       FlutterCrashlytics().log(
//           'error on "addProviderToAccount" api call with status of ${response.statusCode} & body of ${response.body}');
//       log('error with response code ${response.statusCode} and body'
//           ' ${response.body}');
// //        ' ${response.data}');
//
//       throw Exception('error with response code ${response.statusCode} and body'
//           ' ${response.body}');
// //              ' ${response.data}');
//     }
//   }

// cant configure this to dio
//
//   static Future<void> updateSpotifyProvider(String sessionId) async {
//     // String token = await FirebaseAuth.instance.currentUser.getIdToken();
//     String endpoint = address + host + providersNoSlash;
//
//     // dio
//     // Dio dio = new Dio();
//     // dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
//     // var response = await dio.get(endpoint);
//     // http
//     http.Response response = await http.get(endpoint,
//         headers: {HttpHeaders.authorizationHeader: 'Bearer: $token'});
//     if (response.statusCode == 200) {
//       log("got a 200");
//       // log("repo data " + response.data.toString());
//       // var providers = response.data["providers"];
//       // log("providers: " + providers);
//       var providers = AllProvidersDecoder.fromJson(json.decode(response.body));
//       log("providers " + providers.toString());
//       var spotifyProviders =
//       providers.providers.where((element) => element.provider == 'Spotify');
//       log("spot providers " + spotifyProviders.toString());
//       spotifyProviders.toList().sort(
//               (a, b) => a.lastUpdated.iSeconds.compareTo(b.lastUpdated.iSeconds));
//       String putEndpoint = address + host + session + sessionId;
//       Dio dio = new Dio();
//       dio.options.contentType = Headers.formUrlEncodedContentType;
//       if (spotifyProviders?.isNotEmpty) {
//         var put = await dio
//             .put(putEndpoint,
//             data: {
//               "active": true,
//               "authenticationId": "${spotifyProviders.first.id}"
//             },
//             options: Options(headers: {
//               HttpHeaders.authorizationHeader: 'Bearer $token'
//             }))
//             .then(
//                 (value) => log("after adding authId " +
//                 value.statusCode.toString() +
//                 ' ' +
//                 value.data.toString()), onError: (e) {
//           log("there was ana error: " + e.toString());
//           Exception(e.toString());
//         });
//       } else {
//         log("no spotify providers");
//         // addProviderToAccount("spotify");
//         throw Exception('No spotify providers');
//       }
//     } else {
//       // FlutterCrashlytics().log(
//       //     'error on "updateSpotifyProvider" api call with status of ${response.statusCode} & body of '
//       //         '${response.body}');
//       // '${response.data}');
//     }
//     // currently does not return but can be implemented in the future
//     // return {"responseCode": response.statusCode, "message":
//     // // response.body};
//     // response.statusMessage, "body": response.data};
//   }


}