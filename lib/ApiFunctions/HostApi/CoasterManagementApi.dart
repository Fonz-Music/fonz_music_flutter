import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

import '../ApiConstants.dart';
import '../AuthMethods.dart';

class CoasterManagementApi {



  // return owned coasters function
  // GET /host/coasters/
  static Future<Map> getOwnedCoasters() async {
    String endpoint = address + host + coasters;
    String token = await getJWTAndCheckIfExpired();

    // dio
    Dio dio = new Dio();
    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    try {
      var response = await dio.get(endpoint);

      if (response.statusCode == 200) {
        log('success got coasters');
        print("data is " + response.data.toString());
      } else {
        // FlutterCrashlytics().log(
        //     'error on "getOwnedCoasters" api call with status of ${response.statusCode} & body of '
        //     // '${response.body}');
        //         '${response.data}');
        log('error with response code ${response.statusCode} and body '
        // ' ${response.body}');
            ' ${response.data}');
        return null;
      }
      return {
        "statusCode": response.statusCode,
        "code":
        // response.body};
        response.statusMessage,
        "body": response.data
      };
    } on DioError catch (e) {
      // FlutterCrashlytics().log(
      //     'error on "getOwnedCoasters" api call with status of ${e.response.statusCode} & body of '
      //     // '${response.body}');
      //         '${e.response.data}');
      return {
        "statusCode": e.response.statusCode,
        "code": e.response.statusMessage,
        "body": e.response.data
      };
    }
  }

  // view single coaster function
  // GET /host/coaster/{coasterUID}

  // --------------------------------------------now dio---------------------------------------------------------
  static Future<Map> getSingleOwnedCoaster(
      String coasterUID,
      ) async {
    String endpoint = address + host + coasters + coasterUID;
    String token = await getJWTAndCheckIfExpired();
    // dio
    Dio dio = new Dio();
    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    try {
      var response = await dio.get(endpoint);

      if (response.statusCode == 200) {
        log("success getting coaster details");
        if (response.data.isEmpty || response.data == null) {
          response.statusCode = 404;
        }
      }
      else {
        // FlutterCrashlytics().log(
        //     'error on "getSingleOwnedCoaster" api call with status of ${response.statusCode} & body of '
        //     // '${response.body}');
        //         '${response.data}');
        log('error with response code ${response.statusCode} and body '
        // '${response.body}');
            '${response.data}');
//      return null;
      }
      return {
        "statusCode": response.statusCode,
        "code": response.statusMessage,
        "body": response.data
      };
    } on DioError catch (e) {
      // FlutterCrashlytics().log(
      //     'error on "getSingleOwnedCoaster" api call with status of ${e.response.statusCode} & body of '
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
  // check to see if coaster is active
  // static Future<bool> checkCoasterActive(
  //     String coasterUID,
  //     ) async {
  //   String endpoint = address + host + coasters + coasterUID;
  //   String token = await getJWTAndCheckIfExpired();
  //   // String token = await FirebaseAuth.instance.currentUser.getIdToken();
  //   //http
  //   // var response = await http.get(endpoint,
  //   //     headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
  //   // dio
  //   Dio dio = new Dio();
  //   dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
  //   try {
  //     var response = await dio.get(endpoint);
  //
  //     if (response.statusCode == 200) {
  //       log('success got coaster');
  //       log(GetSingleOwnedCoasterDecoder
  //       // .fromJson(json.decode(response.body))
  //           .fromJson(json.decode(response.data))
  //           .active
  //           .toString());
  //       return GetSingleOwnedCoasterDecoder
  //       // .fromJson(json.decode(response.body))
  //           .fromJson(json.decode(response.data))
  //           .active;
  //     } else {
  //       // FlutterCrashlytics().log(
  //       //     'error on "checkCoasterActive" api call with status of ${response.statusCode} & body of '
  //       //     // '${response.body}');
  //       //         '${response.data}');
  //       log('error with response code ${response.statusCode} and body '
  //       // '${response.body}');
  //           '${response.data}');
  //       return null;
  //     }
  //   } on DioError catch (e) {
  //     // FlutterCrashlytics().log(
  //     //     'error on "checkCoasterActive" api call with status of ${e.response.statusCode} & body of '
  //     //     // '${response.body}');
  //     //         '${e.response.data}');
  //     return null;
  //   }
  // }

  // --------------------------------------------now dio---------------------------------------------------------
  // add coaster function
  // /host/coaster/{coasterUID}
  static Future<Map> addCoaster(String coasterUID) async {
    String endpoint = address + host + coasters + coasterUID;
    String token = await getJWTAndCheckIfExpired();
    // dio
    Dio dio = new Dio();
    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    try {
      var response = await dio.post(endpoint, data: {"uid": coasterUID});

      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        log('success added coaster');
      } else if (response.statusCode == 200) {
        log('success added coaster 200');
      } else {
        // FlutterCrashlytics().log(
        //     'error on "addCoaster" api call with status of ${response.statusCode} & body of '
        //     // '${response.body}');
        //         '${response.data}');
        log('error adding coaster');
        // log(response.body);
        log(response.data);
      }
      return {
        "statusCode": response.statusCode,
        "code":
        // response.body};
        response.statusMessage,
        "body": response.data
      };
    } on DioError catch (e) {
      // FlutterCrashlytics().log(
      //     'error on "addCoaster" api call with status of ${e.response.statusCode} & body of '
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
  // make changes to coaster function
  // rename coaster function - include name as param
  static Future renameCoaster(String coasterUID, String coasterName) async {
    String endpoint = address + host + coasters + coasterUID;
    String token = await getJWTAndCheckIfExpired();
    // dio
    Dio dio = new Dio();
    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    try {
      var response = await dio.put(endpoint, data: {'name': coasterName, 'active': true});

      if (response.statusCode == 200) {
        log('success renamed coaster');
//      return EditCoasterDecoder.fromJson(json.decode(response.body))
//          .coasterUID;
      } else if (response.statusCode == 403) {
        // FlutterCrashlytics().log(
        //     'error on "renameCoaster" api call with status of ${response.statusCode} & body of '
        //     // '${response.body}');
        //         '${response.data}');
        log("403 error");
        return '403 error, restricted access';
      } else {
        // FlutterCrashlytics().log(
        //     'error on "renameCoaster" api call with status of ${response.statusCode} & body of '
        //     // '${response.body}');
        //         '${response.data}');
        log(response.statusCode.toString());
        log("didnt rename");
        return 'error renaming Coaster';
      }
    } on DioError catch (e) {
      // FlutterCrashlytics().log(
      //     'error on "renameCoaster" api call with status of ${e.response.statusCode} & body of '
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
  var group;
  bool encoded;

  GetSingleOwnedCoasterDecoder(
      {this.status,
        this.message,
        this.ownedCoaster,
        this.name,
        this.userId,
        this.paused,
        this.active,
      this.group,
      this.encoded});

  GetSingleOwnedCoasterDecoder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    ownedCoaster = json['coaster'];
    name = json['name'];
    paused = json['paused'];
    active = json['active'];
    userId = json['userId'];
    group = json['group'];
    encoded = json['encoded'];
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
    data['group'] = this.group;
    data['encoded'] = this.encoded;
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
