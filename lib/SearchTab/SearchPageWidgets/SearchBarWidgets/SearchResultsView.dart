import 'dart:async';
import 'dart:developer';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestSpotifyApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifySuggestionInterpreter.dart';
import 'package:fonz_music_flutter/ApiFunctions/UserTopTracksResponse.dart';
import 'package:fonz_music_flutter/GlobalComponents/ExceptionHandling.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/CoreUserAttributes.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalFunctions/SpotifyResultsFunctions.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalSessionVariables.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';

import '../TrackButton.dart';
import 'SearchBar.dart';

List<Track> songsSearched;

class SearchResultsView extends StatefulWidget {
  SearchResultsView({Key key}) : super(key: key);

  @override
  _SearchResultsViewState createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<SearchResultsView> {

  Future<List<Track>> _search;
  Future<Map> _result;
  bool isSearching = false;
  bool isLoading = false;

  // var tempTracks = [
  //   Track("Boyfriend", [" Big Time Rush"], "1rKBOL9kJfX1Y4C3QaOvRH", "https://i.scdn.co/image/ab67616d0000b27350acd1f66ebd5b84630c7129"),
  //   Track.withUrl("Is It True", ["Tame Impala"], "6RZmhpvukfyeSURhf4kZ0d", "https://i.scdn.co/image/ab67616d0000b27358267bd34420a00d5cf83a49", "https://open.spotify.com/track/6RZmhpvukfyeSURhf4kZ0d"),
  //   Track.withUrl("The Spirit Of Radio", ["Rush"], "4e9hUiLsN4mx61ARosFi7p", "https://i.scdn.co/image/ab67616d0000b27306c0d7ebcabad0c39b566983", "https://open.spotify.com/track/4e9hUiLsN4mx61ARosFi7p"),
  //   Track.withUrl("Limelight", ["Rush"], "0K6yUnIKNsFtfIpTgGtcHm", "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),
  //   Track("Boyfriend", [" Big Time Rush"], "1rKBOL9kJfX1Y4C3QaOvRH", "https://i.scdn.co/image/ab67616d0000b27350acd1f66ebd5b84630c7129"),
  //   Track.withUrl("Is It True", ["Tame Impala"], "6RZmhpvukfyeSURhf4kZ0d", "https://i.scdn.co/image/ab67616d0000b27358267bd34420a00d5cf83a49", "https://open.spotify.com/track/6RZmhpvukfyeSURhf4kZ0d"),
  //   Track.withUrl("The Spirit Of Radio", ["Rush"], "4e9hUiLsN4mx61ARosFi7p", "https://i.scdn.co/image/ab67616d0000b27306c0d7ebcabad0c39b566983", "https://open.spotify.com/track/4e9hUiLsN4mx61ARosFi7p"),
  //   Track.withUrl("Limelight", ["Rush"], "0K6yUnIKNsFtfIpTgGtcHm", "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),
  //   Track("Boyfriend", [" Big Time Rush"], "1rKBOL9kJfX1Y4C3QaOvRH", "https://i.scdn.co/image/ab67616d0000b27350acd1f66ebd5b84630c7129"),
  //   Track.withUrl("Is It True", ["Tame Impala"], "6RZmhpvukfyeSURhf4kZ0d", "https://i.scdn.co/image/ab67616d0000b27358267bd34420a00d5cf83a49", "https://open.spotify.com/track/6RZmhpvukfyeSURhf4kZ0d"),
  //   Track.withUrl("The Spirit Of Radio", ["Rush"], "4e9hUiLsN4mx61ARosFi7p", "https://i.scdn.co/image/ab67616d0000b27306c0d7ebcabad0c39b566983", "https://open.spotify.com/track/4e9hUiLsN4mx61ARosFi7p"),
  //   Track.withUrl("Limelight", ["Rush"], "0K6yUnIKNsFtfIpTgGtcHm", "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),
  //   Track("Boyfriend", [" Big Time Rush"], "1rKBOL9kJfX1Y4C3QaOvRH", "https://i.scdn.co/image/ab67616d0000b27350acd1f66ebd5b84630c7129"),
  //   Track.withUrl("Is It True", ["Tame Impala"], "6RZmhpvukfyeSURhf4kZ0d", "https://i.scdn.co/image/ab67616d0000b27358267bd34420a00d5cf83a49", "https://open.spotify.com/track/6RZmhpvukfyeSURhf4kZ0d"),
  //   Track.withUrl("The Spirit Of Radio", ["Rush"], "4e9hUiLsN4mx61ARosFi7p", "https://i.scdn.co/image/ab67616d0000b27306c0d7ebcabad0c39b566983", "https://open.spotify.com/track/4e9hUiLsN4mx61ARosFi7p"),
  //   Track.withUrl("Limelight", ["Rush"], "0K6yUnIKNsFtfIpTgGtcHm", "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),
  //   Track("Boyfriend", [" Big Time Rush"], "1rKBOL9kJfX1Y4C3QaOvRH", "https://i.scdn.co/image/ab67616d0000b27350acd1f66ebd5b84630c7129"),
  //   Track.withUrl("Is It True", ["Tame Impala"], "6RZmhpvukfyeSURhf4kZ0d", "https://i.scdn.co/image/ab67616d0000b27358267bd34420a00d5cf83a49", "https://open.spotify.com/track/6RZmhpvukfyeSURhf4kZ0d"),
  //   Track.withUrl("The Spirit Of Radio", ["Rush"], "4e9hUiLsN4mx61ARosFi7p", "https://i.scdn.co/image/ab67616d0000b27306c0d7ebcabad0c39b566983", "https://open.spotify.com/track/4e9hUiLsN4mx61ARosFi7p"),
  //   Track.withUrl("Limelight", ["Rush"], "0K6yUnIKNsFtfIpTgGtcHm", "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),
  //
  // ];

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
    var response;
    EasyDebounce.debounce(
        "sessionSearchPaginated",
        Duration(milliseconds: 400),
            () async {
          log("inside debouncer");
          response = await GuestSpotifyApi.sessionSearch(hostSessionIdGlobal, search); });

    // Make sure the above example finishes before continuting
    await Future.delayed(Duration(milliseconds: 1000));

    // var response = await GuestSpotifyApi.sessionSearch(hostSessionIdGlobal, search);

    var searchResponse;
    log("resp from search " + response.toString());
    if (response == null) {
      log("nothing from seach");
      return songsSearched;
    }
    // if (response.statusCode == 200) {
    if (response["statusCode"] == 200) {
      log("spotiy code: 200");
      // searchResponse = SpotifySearchResultsResponse.fromJson(response["searchResults"]);
      // var body = SpotifyBodySearchResponse.fromJson(searchResults.toJson());
      // searchResponse = SpotifySearchResponse.fromJson(body.toJson());
      searchResponse = SpotifySearchResponse.fromJson(response["body"]["searchResults"]["body"]);

      log("resp from search " + searchResponse.toString());

      log("search presp " + searchResponse.toString());
      var tracks = await searchResponse.tracks.items;
      // var tracks = await searchResponse.
      // List<Track> list = [];
      songsSearched = tracksToList(tracks);



      return songsSearched;
      // try {
      //   for (var i in tracks) {
      //     var albumArt = i.album.images[0].url;
      //     var listArtist = i.artists;
      //     var externalUrl = i.externalUrls.spotify;
      //     List<String> listArtistString = [];
      //     listArtist.forEach((e) => {listArtistString.add(e.name)});
      //     var post = new Track(i.name, listArtistString, i.id, albumArt);
      //     // log("post is " + post.title.toString());
      //     list.add(post);
      //   }
      //   return list;
      // } catch (e) {
      //   throw new GenericException(e);
      // }
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // EasyDebounce.debounce(
    //     "sessionSearchPaginated",
    //     Duration(milliseconds: 1500),
    //         ()  {
    //       log("inside debouncer");
    //       _search = search(searchSong.value); });
    _search = search(searchSong.value);
  // _search = completer.future;

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return
          Stack(
            children: [
              Center(
                child: Container(
                  height: height * 0.72,
                  width: width * COMPONENTWIDTH,
                  decoration: BoxDecoration(
                      color: determineColorThemeBackground(),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
              FutureBuilder(
                future: _search,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    // if (!isSearching) {
                      return SizedBox(
                        height: height * 0.7,
                        // padding: EdgeInsets.all(10),
                        child: Flex(
                          direction: Axis.vertical,
                          children:[ Flexible(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, i) {
                                  return TrackButton(givenTrack: snapshot.data[i]);
                                  // () => print(snapshot.data.items[i].name));
                                }),
                          ),
                  ]
                        ),
                      );
                  }
                  else {
                    return Center(
                        child: Column(
                            children: [
                              Container(
                                height: height * 0.2,
                              ),
                              CircularProgressIndicator(
                                color: AMBER,
                              ),

                            ]
                        )
                    );
                  }
                },
              ),
            ],
          );
    //   },
    //   // child:
    //
    // );
  }
}
class Debouncer<T> {
  Debouncer(this.duration, this.onValue);
  final Duration duration;
  void Function(T value) onValue;
  T _value;
  Timer _timer;
  T get value => _value;
  set value(T val) {
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue(_value));
  }
}
