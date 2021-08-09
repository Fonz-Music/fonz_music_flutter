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

  // CoasterObject.withStatus(this.hostName, this.coasterName, this.sessionId, this.coasterUid, this.statusCode);

  setStatusCode(int code ) {
    this.statusCode = code;
    log("code being set to " + code.toString());
  }

  // int getStatusCode() {
  //   return this.statusCode;
  //   // log("code being set to " + code.toString());
  // }

  setEncodeCoaster(bool newValue ) {
    this.needToEncodeCoaster = newValue;
  }

  updateCoaster(CoasterObject newCoaster) {
    this.hostName = newCoaster.hostName;
    this.coasterUid = newCoaster.coasterUid;
    this.coasterName = newCoaster.coasterName;
    this.statusCode = newCoaster.statusCode;
    this.sessionId = newCoaster.sessionId;
    this.needToEncodeCoaster = newCoaster.needToEncodeCoaster;
  }

}