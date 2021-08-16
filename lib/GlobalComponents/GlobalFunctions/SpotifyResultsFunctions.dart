

import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';

List<Track> tracksToList(tracks) {
  List<Track> trackList = [];

    for (var i in tracks) {
      var albumArt = i.album.images[0].url;
      var listArtist = i.artists;
      var externalUrl = i.externalUrls.spotify;
      List<String> listArtistString = [];
      listArtist.forEach((e) => {listArtistString.add(e.name)});
      var post = new Track(i.name, listArtistString, i.id, albumArt);
      // log("post is " + post.title.toString());
      trackList.add(post);
    }


  return trackList;
}