// CoasterInfo is the information handler for the info stored in the coaster
class CoasterObject {
  String hostName;
  String coasterName;
  String coasterUid;
  String sessionId;
  int statusCode = 0;


  CoasterObject(this.hostName, this.coasterName, this.sessionId, this.coasterUid);
}