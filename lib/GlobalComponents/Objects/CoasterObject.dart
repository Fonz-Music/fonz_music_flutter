// CoasterInfo is the information handler for the info stored in the coaster
import 'dart:developer';

class CoasterObject {
  String hostName;
  String coasterName;
  String coasterUid;
  String sessionId;
  int statusCode = 0;
  bool needToEncodeCoaster = false;


  CoasterObject(this.hostName, this.coasterName, this.sessionId, this.coasterUid);

  setStatusCode(int code ) {
    this.statusCode = code;
    log("code being set to " + code.toString());
  }
  setEncodeCoaster(bool newValue ) {
    this.needToEncodeCoaster = newValue;
  }
}