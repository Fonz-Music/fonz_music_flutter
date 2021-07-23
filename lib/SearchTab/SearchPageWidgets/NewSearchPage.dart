import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestSpotifyApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifySuggestionInterpreter.dart';
import 'package:fonz_music_flutter/ApiFunctions/UserTopArtistsResponse.dart';
import 'package:fonz_music_flutter/ApiFunctions/UserTopTracksResponse.dart';
import 'package:fonz_music_flutter/GlobalComponents/ExceptionHandling.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalVariables.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Post.dart';
import 'package:http/http.dart';

class NewSearchPage extends StatefulWidget {
  NewSearchPage({Key key}) : super(key: key);

  @override
  _NewSearchPageState createState() => _NewSearchPageState();
}

class _NewSearchPageState extends State<NewSearchPage> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      width: width,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SearchBar(),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _formKey = new GlobalKey<FormState>(debugLabel: 'Searchbar form key');
  TextEditingController _searchController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
      width: width,
      child: Form(
          key: _formKey,
          child: Row(
            children: <Widget>[
              Icon(Icons.search),
              Container(
                width: width * 0.8,
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Search'),
                  controller: _searchController,
                  focusNode: _focusNode,
                ),
              ),
            ],
          )),
    );
  }
}

class SongRecPane extends StatelessWidget {
  const SongRecPane({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}

class SearchResultsPane extends StatefulWidget {
  SearchResultsPane({Key key}) : super(key: key);

  @override
  _SearchResultsPaneState createState() => _SearchResultsPaneState();
}

class _SearchResultsPaneState extends State<SearchResultsPane> {
  final Future<UserTopTracksResponse> _result = GuestSpotifyApi.getUserTopTracks();
  Future<List<Post>> _search;
  bool isSearching = false;
  bool isLoading = false;

  List<Post> getItems(SpotifySearchResponse response) {
    var tracks = response.tracks.items;
    var list;
    for (var i in tracks) {
      var albumArt = i.album.images[0].url;
      var listArtist = i.artists.toList();
      var listArtistString;
      for (var j in listArtist) {
        listArtistString.add(listArtist.indexOf(j));
      }
      var post = new Post(i.name, listArtistString, i.id, albumArt);
      list.add(post);
    }
    log(list.toString());
    return list;
  }

  Future<List<Post>> search(String search) async {
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
      List<Post> list = [];
      try {
        for (var i in tracks) {
          var albumArt = i.album.images[0].url;
          var listArtist = i.artists;
          var externalUrl = i.externalUrls.spotify;
          List<String> listArtistString = [];
          listArtist.forEach((e) => {listArtistString.add(e.name)});
          var post = new Post(i.name, listArtistString, i.id, albumArt);
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
    return FutureBuilder(
      future: _result,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (!isSearching) {
            return Container(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, i) {
                    return TrackResultRow(snapshot.data.items[i],
                        () => print(snapshot.data.items[i].name));
                  }),
            );
          } else {
            return FutureBuilder(
              future: _search,
              initialData: CircularProgressIndicator(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    child: ListView.builder(itemBuilder: (context, i) {
                      return ListTile(
                        leading: Image.network(snapshot.data[i].imageLink),
                        title: snapshot.data[i].name,
                      );
                    }),
                  );
                } else if (snapshot.hasError) {
                  throw new GenericException(snapshot.error);
                }
                return CircularProgressIndicator();
              },
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
