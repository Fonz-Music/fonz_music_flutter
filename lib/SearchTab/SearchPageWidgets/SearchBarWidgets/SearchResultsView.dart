import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestSpotifyApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifySuggestionInterpreter.dart';
import 'package:fonz_music_flutter/ApiFunctions/UserTopTracksResponse.dart';
import 'package:fonz_music_flutter/GlobalComponents/ExceptionHandling.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/CoreUserAttributes.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';

import '../TrackButton.dart';


class SearchResultsView extends StatefulWidget {
  SearchResultsView({Key key}) : super(key: key);

  @override
  _SearchResultsViewState createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<SearchResultsView> {
  final Future<UserTopTracksResponse> _result = GuestSpotifyApi.getUserTopTracks();
  Future<List<Track>> _search;
  bool isSearching = false;
  bool isLoading = false;

  var tempTracks = [
    Track("Boyfriend", [" Big Time Rush"], "1rKBOL9kJfX1Y4C3QaOvRH", "https://i.scdn.co/image/ab67616d0000b27350acd1f66ebd5b84630c7129"),
    Track.withUrl("Is It True", ["Tame Impala"], "6RZmhpvukfyeSURhf4kZ0d", "https://i.scdn.co/image/ab67616d0000b27358267bd34420a00d5cf83a49", "https://open.spotify.com/track/6RZmhpvukfyeSURhf4kZ0d"),
    Track.withUrl("The Spirit Of Radio", ["Rush"], "4e9hUiLsN4mx61ARosFi7p", "https://i.scdn.co/image/ab67616d0000b27306c0d7ebcabad0c39b566983", "https://open.spotify.com/track/4e9hUiLsN4mx61ARosFi7p"),
    Track.withUrl("Limelight", ["Rush"], "0K6yUnIKNsFtfIpTgGtcHm", "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),
    Track("Boyfriend", [" Big Time Rush"], "1rKBOL9kJfX1Y4C3QaOvRH", "https://i.scdn.co/image/ab67616d0000b27350acd1f66ebd5b84630c7129"),
    Track.withUrl("Is It True", ["Tame Impala"], "6RZmhpvukfyeSURhf4kZ0d", "https://i.scdn.co/image/ab67616d0000b27358267bd34420a00d5cf83a49", "https://open.spotify.com/track/6RZmhpvukfyeSURhf4kZ0d"),
    Track.withUrl("The Spirit Of Radio", ["Rush"], "4e9hUiLsN4mx61ARosFi7p", "https://i.scdn.co/image/ab67616d0000b27306c0d7ebcabad0c39b566983", "https://open.spotify.com/track/4e9hUiLsN4mx61ARosFi7p"),
    Track.withUrl("Limelight", ["Rush"], "0K6yUnIKNsFtfIpTgGtcHm", "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),
    Track("Boyfriend", [" Big Time Rush"], "1rKBOL9kJfX1Y4C3QaOvRH", "https://i.scdn.co/image/ab67616d0000b27350acd1f66ebd5b84630c7129"),
    Track.withUrl("Is It True", ["Tame Impala"], "6RZmhpvukfyeSURhf4kZ0d", "https://i.scdn.co/image/ab67616d0000b27358267bd34420a00d5cf83a49", "https://open.spotify.com/track/6RZmhpvukfyeSURhf4kZ0d"),
    Track.withUrl("The Spirit Of Radio", ["Rush"], "4e9hUiLsN4mx61ARosFi7p", "https://i.scdn.co/image/ab67616d0000b27306c0d7ebcabad0c39b566983", "https://open.spotify.com/track/4e9hUiLsN4mx61ARosFi7p"),
    Track.withUrl("Limelight", ["Rush"], "0K6yUnIKNsFtfIpTgGtcHm", "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),
    Track("Boyfriend", [" Big Time Rush"], "1rKBOL9kJfX1Y4C3QaOvRH", "https://i.scdn.co/image/ab67616d0000b27350acd1f66ebd5b84630c7129"),
    Track.withUrl("Is It True", ["Tame Impala"], "6RZmhpvukfyeSURhf4kZ0d", "https://i.scdn.co/image/ab67616d0000b27358267bd34420a00d5cf83a49", "https://open.spotify.com/track/6RZmhpvukfyeSURhf4kZ0d"),
    Track.withUrl("The Spirit Of Radio", ["Rush"], "4e9hUiLsN4mx61ARosFi7p", "https://i.scdn.co/image/ab67616d0000b27306c0d7ebcabad0c39b566983", "https://open.spotify.com/track/4e9hUiLsN4mx61ARosFi7p"),
    Track.withUrl("Limelight", ["Rush"], "0K6yUnIKNsFtfIpTgGtcHm", "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),
    Track("Boyfriend", [" Big Time Rush"], "1rKBOL9kJfX1Y4C3QaOvRH", "https://i.scdn.co/image/ab67616d0000b27350acd1f66ebd5b84630c7129"),
    Track.withUrl("Is It True", ["Tame Impala"], "6RZmhpvukfyeSURhf4kZ0d", "https://i.scdn.co/image/ab67616d0000b27358267bd34420a00d5cf83a49", "https://open.spotify.com/track/6RZmhpvukfyeSURhf4kZ0d"),
    Track.withUrl("The Spirit Of Radio", ["Rush"], "4e9hUiLsN4mx61ARosFi7p", "https://i.scdn.co/image/ab67616d0000b27306c0d7ebcabad0c39b566983", "https://open.spotify.com/track/4e9hUiLsN4mx61ARosFi7p"),
    Track.withUrl("Limelight", ["Rush"], "0K6yUnIKNsFtfIpTgGtcHm", "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),

  ];

  List<Track> getItems(SpotifySearchResponse response) {
    var tracks = response.tracks.items;
    var list;
    for (var i in tracks) {
      var albumArt = i.album.images[0].url;
      var listArtist = i.artists.toList();
      var listArtistString;
      for (var j in listArtist) {
        listArtistString.add(listArtist.indexOf(j));
      }
      var post = new Track(i.name, listArtistString, i.id, albumArt);
      list.add(post);
    }
    log(list.toString());
    return list;
  }

  Future<List<Track>> search(String search) async {
    log("beginning search");
    var account;
    // String token = await FirebaseAuth.instance.currentUser.getIdToken();
    log("got token");
    search.trim();
    search.replaceAll(' ', '+');
    //TODO: add handler for statuscode 403 invalid web token
    // Current tests based on host credentials
    //TODO: use based on guest sid

    // var host = await RepositoryServiceAuth.getActiveHostAccount();

    var response = await GuestSpotifyApi.sessionSearch(hostSessionIdGlobal, search);

    var searchResponse;
    log("resp from search " + response.toString());
    // if (response.statusCode == 200) {
    if (response["responseCode"] == 200) {
      log("spotiy code: 200");
      searchResponse = SpotifySearchResponse.fromJson(response["body"]);

      log("search presp " + searchResponse.toString());
      var tracks = await searchResponse.tracks.items;
      List<Track> list = [];
      try {
        for (var i in tracks) {
          var albumArt = i.album.images[0].url;
          var listArtist = i.artists;
          var externalUrl = i.externalUrls.spotify;
          List<String> listArtistString = [];
          listArtist.forEach((e) => {listArtistString.add(e.name)});
          var post = new Track(i.name, listArtistString, i.id, albumArt);
          list.add(post);
        }
        return list;
      } catch (e) {
        throw new GenericException(e);
      }
      // } else if (response.statusCode == 403) {
    } else if (response["responseCode"] == 403) {
      log('Invalid jwt when trying to search spotify');
      String errorMessageSongSearch =
          "looks like theres an issue with your host's connection to their Spotify.";
      log(response["body"]);
      throw GenericException(
          Exception(response["body"] + "\n" + errorMessageSongSearch));

      // } else if (response.statusCode == 500) {
    } else if (response["responseCode"] == 500) {
      log('issue with spotify authorization');
      // http
      // log(response.body);
      // dio
      log(response["body"]);

      String errorMessageSongSearch =
          "have your host refresh their spotify login on the providers dashboard.";
      throw new GenericException(Exception(errorMessageSongSearch));
    } else {
      log('issue with search');
      String errorMessageSongSearch =
          "something isn't right :/ \nensure that your internet connection is strong & try again";
      // http
      // log(response.body);
      // dio
      log(response["data"]);

      throw new GenericException(Exception(errorMessageSongSearch));
    }
  }

  @override
  void initState() {
    // TODO: implement initState and fill in term
    _search = search('term');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    // return FutureBuilder(
    //   future: _result,
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (snapshot.hasData) {
    //       if (!isSearching) {
            return SizedBox(
              height: height,
              // padding: EdgeInsets.all(10),
              child: Flexible(
                child: ListView.builder(
                    // itemCount: 10,
                    // itemBuilder: (context, i) {
                    //   return TrackResultRow(snapshot.data.items[i],
                    //           () => print(snapshot.data.items[i].name));
                    // }),
                itemCount: tempTracks.length,
        itemBuilder: (context, i) {
                  return TrackButton(givenTrack: tempTracks[i]);
        }),
              ),
            );
      //     } else {
      //       return FutureBuilder(
      //         future: _search,
      //         initialData: CircularProgressIndicator(),
      //         builder: (BuildContext context, AsyncSnapshot snapshot) {
      //           if (snapshot.hasData) {
      //             return Container(
      //               child: ListView.builder(itemBuilder: (context, i) {
      //                 return ListTile(
      //                   leading: Image.network(snapshot.data[i].imageLink),
      //                   title: snapshot.data[i].name,
      //                 );
      //               }),
      //             );
      //           } else if (snapshot.hasError) {
      //             throw new GenericException(snapshot.error);
      //           }
      //           return CircularProgressIndicator();
      //         },
      //       );
      //     }
      //   } else {
      //     return CircularProgressIndicator();
      //   }
      // },
    // );
  }
}
