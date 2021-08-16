

import 'dart:developer';

import 'package:fonz_music_flutter/ApiFunctions/SpotifySuggestionInterpreter.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';

List<Track> tracksToList(tracks) {
  List<Track> trackList = [];

  log("in tracksToList");
  log("tracks are " + tracks.toString());
    for (var i in tracks) {
      var albumArt = i.album.images[0].url;
      log("album art is " + i.album.images[0].url);
      var listArtist = i.artists;
      log("artist is " + i.artists.toString());
      var externalUrl = i.externalUrls.spotify;
      log("external is " + i.externalUrls.spotify);
      List<String> listArtistString = [];
      listArtist.forEach((e) => {listArtistString.add(e.name)});
      var post = new Track(i.name, listArtistString, i.id, albumArt);
      log("post is " + post.title.toString());
      trackList.add(post);
    }


  return trackList;
}
List<Track> tracksJsonToList(tracks) {
  List<Track> trackList = [];

  log("in tracksToList");
  // log("tracks are " + tracks.toString());
  for (var i in tracks) {
    var albumArt = i["album"]["images"][0]["url"];
    log("album art is " + i["album"]["images"][0]["url"]);
    var listArtist = i["artists"];
    log("artist is " + i["artists"].toString());
    var externalUrl = i["external_urls"]["spotify"];
    log("external is " + i["external_urls"]["spotify"]);
    List<String> listArtistString = [];
    listArtist.forEach((e) => {listArtistString.add(e["name"])});
    var post = new Track(i["name"], listArtistString, i["id"], albumArt);
    log("post is " + post.title.toString());
    trackList.add(post);
  }


  return trackList;
}