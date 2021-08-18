

import 'dart:developer';

import 'package:fonz_music_flutter/ApiFunctions/SpotifySuggestionInterpreter.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Artist.dart';
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
List<Artist> artistsJsonToList(artists) {
  List<Artist> artistList = [];

  log("in artistsToList");
  log("artists are " + artists.toString());
  for (var i in artists) {
    log("about to get art");
    log("name is " + i["name"]);
    var artistArt = i["images"][0]["url"];
    log("artust art is " + i["images"][0]["url"]);

    var newArtist = new Artist(i["name"], i["id"], artistArt);
    log("post is " + newArtist.artistName.toString());
    artistList.add(newArtist);
  }


  return artistList;
}