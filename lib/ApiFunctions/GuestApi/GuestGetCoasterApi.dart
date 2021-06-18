import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

import '../ApiConstants.dart';
// import 'package:http/http.dart' as http;



class GuestGetCoasterApi {


  static Future<Map> getCoasterDetails(String uid) async {
    log("im getting called ");
    String endpoint = address + guest + coaster + uid;
    String token = "";
    // await FirebaseAuth.instance.currentUser.getIdToken();
    log("endpoint: " + endpoint);

    // dio
    Dio dio = new Dio();

    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    var response = await dio.get(endpoint);
    log("dio works");
    //http
    // var response = await http.get(endpoint,
    //     headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    if (response.statusCode == 200) {
//      log('success got coasters');
      log("success");
    } else {
      log("error ");
      log('error with response code ${response.statusCode} and body '
      // ' ${response.body}');
          ' ${response.data}');
      return null;
    }
    // log("response message " + response.statusMessage);
    // log("response code " + response.statusCode.toString());
    return {"responseCode": response.statusCode, "statusMessage": response.statusMessage,
      "body": response.data};
  }
}