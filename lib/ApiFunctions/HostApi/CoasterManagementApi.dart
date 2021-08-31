import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

import '../ApiConstants.dart';
import '../AuthMethods.dart';

class CoasterManagementApi {




  // --------------------------------------------now dio---------------------------------------------------------
  // make changes to coaster function
  // rename coaster function - include name as param
  static Future classifyCoasterAsEncoded(String coasterUID, bool encoded, String group) async {
    String endpoint = address + host + coasters + coasterUID;
    String token = await getJWTAndCheckIfExpired();
    // dio
    Dio dio = new Dio();
    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    try {
      var response;
      if (group != "") {
         response = await dio.put(endpoint, data: {'encoded': encoded, 'group': group});
      }
      else {
         response = await dio.put(endpoint, data: {'encoded': encoded});
      }

      var responseMessage;

      if (response.statusCode == 200) {
        log('success renamed coaster');
        responseMessage = "SUCCESS_UPDATING_DB";
        return responseMessage;
      } else {
        responseMessage = "FAIL_UPDATING_DB";
        return responseMessage;
      }
    } on DioError catch (e) {
      return "FAIL_UPDATING_DB";
    }
  }

  // --------------------------------------------now dio---------------------------------------------------------
  // disable coaster function - change bool
  // PUT /host/coaster/{coasterUID} body: { paused: true|false, disabled: true|false, name: 'string'}
  static Future pauseCoaster(String coasterUID, bool active) async {
    log("bool is " + active.toString());
    String endpoint = address + host + coasters + coasterUID;
    String token = await getJWTAndCheckIfExpired();
    // String token = await FirebaseAuth.instance.currentUser.getIdToken();
    // http
    // var response = await http.put(endpoint,
    //     headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    //     body: {"active": paused.toString()});
    // dio
    Dio dio = new Dio();
    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    try {
      var response =
      await dio.put(endpoint, data: {"active": active});

      if (response.statusCode == 200) {
        log('success paused coaster');
//      return EditCoasterDecoder.fromJson(json.decode(response.body))
//          .coasterUID;
      } else {
        // FlutterCrashlytics().log(
        //     'error on "pauseCoaster" api call with status of ${response.statusCode} & body of '
        //     // '${response.body}');
        //         '${response.data}');
        log("didnt pause coaster");
        return 'error pausing Coaster';
      }
    } on DioError catch (e) {
      // FlutterCrashlytics().log(
      //     'error on "pauseCoaster" api call with status of ${e.response.statusCode} & body of '
      //     // '${response.body}');
      //         '${e.response.data}');
      return {
        "statusCode": e.response.statusCode,
        "code": e.response.statusMessage,
        "body": e.response.data
      };
    }
  }

  // --------------------------------------------now dio---------------------------------------------------------
  // edit coaster function
  // will be an umbrella function for now
  // static Future<String> editCoaster(
  //     String coasterUID, bool paused, bool disabled, String coasterName) async {
  //   String endpoint = address + host + coasters + coasterUID;
  //   String token = await getJWTAndCheckIfExpired();
  //   // String token = await FirebaseAuth.instance.currentUser.getIdToken();
  //   // http
  //   // var response = await http.put(endpoint,
  //   //     headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
  //   //     body: {paused: paused, disabled: disabled, coasterName: coasterName});
  //   // dio
  //   Dio dio = new Dio();
  //   dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
  //   try {
  //     var response = await dio.put(endpoint,
  //         data: {"paused": paused, disabled: disabled, coasterName: coasterName});
  //
  //     if (response.statusCode == 201) {
  //       log('success edited coaster');
  //       // return AddCoasterDecoder.fromJson(json.decode(response.body)).coasterUID;
  //       return AddCoasterDecoder.fromJson(json.decode(response.data))
  //           .coasterUID;
  //     } else {
  //       // FlutterCrashlytics().log(
  //       //     'error on "editCoaster" api call with status of ${response.statusCode} & body of '
  //       //     // '${response.body}');
  //       //         '${response.data}');
  //       return 'error editing Coaster';
  //     }
  //   } on DioError catch (e) {
  //     // FlutterCrashlytics().log(
  //     //     'error on "editCoaster" api call with status of ${e.response.statusCode} & body of '
  //     //     // '${response.body}');
  //     //         '${e.response.data}');
  //     return "error editing coaster";
  //   }
  // }

  // --------------------------------------------now dio---------------------------------------------------------
  // delete coaster function
  // DELETE /host/coaster/{coasterUID}
  static Future disconnectCoaster(String coasterUID) async {
    String endpoint = address + host + coasters + coasterUID;
    String token = await getJWTAndCheckIfExpired();
    // dio
    Dio dio = new Dio();
    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    try {
      var response = await dio.delete(endpoint);

      if (response.statusCode == 200) {
        log('success disconnected coaster');
//      return AddCoasterDecoder.fromJson(json.decode(response.body))
//          .coasterUID;
      } else {
        // FlutterCrashlytics().log(
        //     'error on "disconnectCoaster" api call with status of ${response.statusCode} & body of '
        //     // '${response.body}');
        //         '${response.data}');
        log('error deleting Coaster');
        // log(response.body);
        return 'error deleting Coaster';
      }
    } on DioError catch (e) {
      // FlutterCrashlytics().log(
      //     'error on "disconnectCoaster" api call with status of ${e.response.statusCode} & body of '
      //     // '${response.body}');
      //         '${e.response.data}');
      print("error is " + e.toString());
      return {
        "statusCode": e.response.data["status"],
        "code": e.response.data["code"],
        "body": e.response.data["body"]
      };
    }
  }

}


// get owned coasters

class GetOwnedCoastersDecoder {
  int status;
  String message;
  List ownedCoasters;
  int quantity;

  GetOwnedCoastersDecoder(
      {this.status, this.message, this.ownedCoasters, this.quantity});

  GetOwnedCoastersDecoder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    ownedCoasters = json['coasters'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['coasters'] = this.ownedCoasters;
    data['quantity'] = this.quantity;
    return data;
  }
}

// get single owned coaster

class GetSingleOwnedCoasterDecoder {
  Map ownedCoaster;
  int status;
  String message;
  String name;
  bool paused;
  bool active;
  String userId;

  GetSingleOwnedCoasterDecoder(
      {this.status,
        this.message,
        this.ownedCoaster,
        this.name,
        this.userId,
        this.paused,
        this.active});

  GetSingleOwnedCoasterDecoder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    ownedCoaster = json['coaster'];
    name = json['name'];
    paused = json['paused'];
    active = json['active'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['coaster'] = this.ownedCoaster;
    data['name'] = this.name;
    data['paused'] = this.paused;
    data['active'] = this.active;
    data['userId'] = this.userId;

    return data;
  }
}

// add coaster decoder

class AddCoasterDecoder {
  int status;
  String message;
  String coasterUID;

  AddCoasterDecoder({this.status, this.message, this.coasterUID});

  AddCoasterDecoder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    coasterUID = json['coasterUID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['coasterUID'] = this.coasterUID;
    return data;
  }
}

// edit coaster decoder

class EditCoasterDecoder {
  int status;
  String message;
  String coasterUID;

  EditCoasterDecoder({this.status, this.message, this.coasterUID});

  EditCoasterDecoder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    coasterUID = json['coasterUID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['coasterUID'] = this.coasterUID;
    return data;
  }
}
