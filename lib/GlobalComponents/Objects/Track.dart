import 'package:fonz_music_flutter/ApiFunctions/ApiConstants.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestGetCoasterApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestSpotifyApi.dart';

import '../CoreUserAttributes.dart';
import '../GlobalSessionVariables.dart';
// search bar widget
class Track {
  String title;
  List<String> artist;
  String trackID;
  String imageLink;
  String songUrl = "";

  Track(this.title, this.artist, this.trackID, this.imageLink);
  Track.withUrl(this.title, this.artist, this.trackID, this.imageLink, this.songUrl);
  Future<Map> queueSpotify() async {
    var getHostResponse;
    // attempts to queue a song to spotify and throws an error if incomplete
    //   var host = await RepositoryServiceAuth.getActiveHostAccount();

    if (host == null) {
      return {
        "statusCode": 400,
        "message": "you don't have a host.. who do you know here?"
      };
    } else {
      // TODO: fix guest API
      getHostResponse =
          await GuestSpotifyApi.queueTrackSpotify(this.trackID, hostSessionIdGlobal);
      //await GuestApi.queueTrackSpotify(this.trackID, host.hostId);

      return {
        "statusCode": getHostResponse["responseCode"],
        "message": getHostResponse["body"]
      };
    }
  }
}
