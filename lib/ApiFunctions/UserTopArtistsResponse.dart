// import 'package:flutter/material.dart';
//
// class UserTopArtistsResponse {
//   List<Items> _items;
//   int _total;
//   int _limit;
//   int _offset;
//   Null _previous;
//   String _href;
//   String _next;
//
//   UserTopArtistsResponse(
//       {List<Items> items,
//       int total,
//       int limit,
//       int offset,
//       Null previous,
//       String href,
//       String next}) {
//     this._items = items;
//     this._total = total;
//     this._limit = limit;
//     this._offset = offset;
//     this._previous = previous;
//     this._href = href;
//     this._next = next;
//   }
//
//   List<Items> get items => _items;
//   set items(List<Items> items) => _items = items;
//   int get total => _total;
//   set total(int total) => _total = total;
//   int get limit => _limit;
//   set limit(int limit) => _limit = limit;
//   int get offset => _offset;
//   set offset(int offset) => _offset = offset;
//   Null get previous => _previous;
//   set previous(Null previous) => _previous = previous;
//   String get href => _href;
//   set href(String href) => _href = href;
//   String get next => _next;
//   set next(String next) => _next = next;
//
//   UserTopArtistsResponse.fromJson(Map<String, dynamic> json) {
//     if (json['items'] != null) {
//       _items = new List<Items>();
//       json['items'].forEach((v) {
//         _items.add(new Items.fromJson(v));
//       });
//     }
//     _total = json['total'];
//     _limit = json['limit'];
//     _offset = json['offset'];
//     _previous = json['previous'];
//     _href = json['href'];
//     _next = json['next'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this._items != null) {
//       data['items'] = this._items.map((v) => v.toJson()).toList();
//     }
//     data['total'] = this._total;
//     data['limit'] = this._limit;
//     data['offset'] = this._offset;
//     data['previous'] = this._previous;
//     data['href'] = this._href;
//     data['next'] = this._next;
//     return data;
//   }
// }
//
// class Items {
//   ExternalUrls _externalUrls;
//   Followers _followers;
//   List<String> _genres;
//   String _href;
//   String _id;
//   List<Images> _images;
//   String _name;
//   int _popularity;
//   String _type;
//   String _uri;
//
//   Items(
//       {ExternalUrls externalUrls,
//       Followers followers,
//       List<String> genres,
//       String href,
//       String id,
//       List<Images> images,
//       String name,
//       int popularity,
//       String type,
//       String uri}) {
//     this._externalUrls = externalUrls;
//     this._followers = followers;
//     this._genres = genres;
//     this._href = href;
//     this._id = id;
//     this._images = images;
//     this._name = name;
//     this._popularity = popularity;
//     this._type = type;
//     this._uri = uri;
//   }
//
//   ExternalUrls get externalUrls => _externalUrls;
//   set externalUrls(ExternalUrls externalUrls) => _externalUrls = externalUrls;
//   Followers get followers => _followers;
//   set followers(Followers followers) => _followers = followers;
//   List<String> get genres => _genres;
//   set genres(List<String> genres) => _genres = genres;
//   String get href => _href;
//   set href(String href) => _href = href;
//   String get id => _id;
//   set id(String id) => _id = id;
//   List<Images> get images => _images;
//   set images(List<Images> images) => _images = images;
//   String get name => _name;
//   set name(String name) => _name = name;
//   int get popularity => _popularity;
//   set popularity(int popularity) => _popularity = popularity;
//   String get type => _type;
//   set type(String type) => _type = type;
//   String get uri => _uri;
//   set uri(String uri) => _uri = uri;
//
//   Items.fromJson(Map<String, dynamic> json) {
//     _externalUrls = json['external_urls'] != null
//         ? new ExternalUrls.fromJson(json['external_urls'])
//         : null;
//     _followers = json['followers'] != null
//         ? new Followers.fromJson(json['followers'])
//         : null;
//     _genres = json['genres'].cast<String>();
//     _href = json['href'];
//     _id = json['id'];
//     if (json['images'] != null) {
//       _images = new List<Images>();
//       json['images'].forEach((v) {
//         _images.add(new Images.fromJson(v));
//       });
//     }
//     _name = json['name'];
//     _popularity = json['popularity'];
//     _type = json['type'];
//     _uri = json['uri'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this._externalUrls != null) {
//       data['external_urls'] = this._externalUrls.toJson();
//     }
//     if (this._followers != null) {
//       data['followers'] = this._followers.toJson();
//     }
//     data['genres'] = this._genres;
//     data['href'] = this._href;
//     data['id'] = this._id;
//     if (this._images != null) {
//       data['images'] = this._images.map((v) => v.toJson()).toList();
//     }
//     data['name'] = this._name;
//     data['popularity'] = this._popularity;
//     data['type'] = this._type;
//     data['uri'] = this._uri;
//     return data;
//   }
// }
//
// class ExternalUrls {
//   String _spotify;
//
//   ExternalUrls({String spotify}) {
//     this._spotify = spotify;
//   }
//
//   String get spotify => _spotify;
//   set spotify(String spotify) => _spotify = spotify;
//
//   ExternalUrls.fromJson(Map<String, dynamic> json) {
//     _spotify = json['spotify'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['spotify'] = this._spotify;
//     return data;
//   }
// }
//
// class Followers {
//   Null _href;
//   int _total;
//
//   Followers({Null href, int total}) {
//     this._href = href;
//     this._total = total;
//   }
//
//   Null get href => _href;
//   set href(Null href) => _href = href;
//   int get total => _total;
//   set total(int total) => _total = total;
//
//   Followers.fromJson(Map<String, dynamic> json) {
//     _href = json['href'];
//     _total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['href'] = this._href;
//     data['total'] = this._total;
//     return data;
//   }
// }
//
// class Images {
//   int _height;
//   String _url;
//   int _width;
//
//   Images({int height, String url, int width}) {
//     this._height = height;
//     this._url = url;
//     this._width = width;
//   }
//
//   int get height => _height;
//   set height(int height) => _height = height;
//   String get url => _url;
//   set url(String url) => _url = url;
//   int get width => _width;
//   set width(int width) => _width = width;
//
//   Images.fromJson(Map<String, dynamic> json) {
//     _height = json['height'];
//     _url = json['url'];
//     _width = json['width'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['height'] = this._height;
//     data['url'] = this._url;
//     data['width'] = this._width;
//     return data;
//   }
// }// import 'package:flutter/material.dart';
// //
// // class UserTopArtistsResponse {
// //   List<Items> _items;
// //   int _total;
// //   int _limit;
// //   int _offset;
// //   Null _previous;
// //   String _href;
// //   String _next;
// //
// //   UserTopArtistsResponse(
// //       {List<Items> items,
// //       int total,
// //       int limit,
// //       int offset,
// //       Null previous,
// //       String href,
// //       String next}) {
// //     this._items = items;
// //     this._total = total;
// //     this._limit = limit;
// //     this._offset = offset;
// //     this._previous = previous;
// //     this._href = href;
// //     this._next = next;
// //   }
// //
// //   List<Items> get items => _items;
// //   set items(List<Items> items) => _items = items;
// //   int get total => _total;
// //   set total(int total) => _total = total;
// //   int get limit => _limit;
// //   set limit(int limit) => _limit = limit;
// //   int get offset => _offset;
// //   set offset(int offset) => _offset = offset;
// //   Null get previous => _previous;
// //   set previous(Null previous) => _previous = previous;
// //   String get href => _href;
// //   set href(String href) => _href = href;
// //   String get next => _next;
// //   set next(String next) => _next = next;
// //
// //   UserTopArtistsResponse.fromJson(Map<String, dynamic> json) {
// //     if (json['items'] != null) {
// //       _items = new List<Items>();
// //       json['items'].forEach((v) {
// //         _items.add(new Items.fromJson(v));
// //       });
// //     }
// //     _total = json['total'];
// //     _limit = json['limit'];
// //     _offset = json['offset'];
// //     _previous = json['previous'];
// //     _href = json['href'];
// //     _next = json['next'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     if (this._items != null) {
// //       data['items'] = this._items.map((v) => v.toJson()).toList();
// //     }
// //     data['total'] = this._total;
// //     data['limit'] = this._limit;
// //     data['offset'] = this._offset;
// //     data['previous'] = this._previous;
// //     data['href'] = this._href;
// //     data['next'] = this._next;
// //     return data;
// //   }
// // }
// //
// // class Items {
// //   ExternalUrls _externalUrls;
// //   Followers _followers;
// //   List<String> _genres;
// //   String _href;
// //   String _id;
// //   List<Images> _images;
// //   String _name;
// //   int _popularity;
// //   String _type;
// //   String _uri;
// //
// //   Items(
// //       {ExternalUrls externalUrls,
// //       Followers followers,
// //       List<String> genres,
// //       String href,
// //       String id,
// //       List<Images> images,
// //       String name,
// //       int popularity,
// //       String type,
// //       String uri}) {
// //     this._externalUrls = externalUrls;
// //     this._followers = followers;
// //     this._genres = genres;
// //     this._href = href;
// //     this._id = id;
// //     this._images = images;
// //     this._name = name;
// //     this._popularity = popularity;
// //     this._type = type;
// //     this._uri = uri;
// //   }
// //
// //   ExternalUrls get externalUrls => _externalUrls;
// //   set externalUrls(ExternalUrls externalUrls) => _externalUrls = externalUrls;
// //   Followers get followers => _followers;
// //   set followers(Followers followers) => _followers = followers;
// //   List<String> get genres => _genres;
// //   set genres(List<String> genres) => _genres = genres;
// //   String get href => _href;
// //   set href(String href) => _href = href;
// //   String get id => _id;
// //   set id(String id) => _id = id;
// //   List<Images> get images => _images;
// //   set images(List<Images> images) => _images = images;
// //   String get name => _name;
// //   set name(String name) => _name = name;
// //   int get popularity => _popularity;
// //   set popularity(int popularity) => _popularity = popularity;
// //   String get type => _type;
// //   set type(String type) => _type = type;
// //   String get uri => _uri;
// //   set uri(String uri) => _uri = uri;
// //
// //   Items.fromJson(Map<String, dynamic> json) {
// //     _externalUrls = json['external_urls'] != null
// //         ? new ExternalUrls.fromJson(json['external_urls'])
// //         : null;
// //     _followers = json['followers'] != null
// //         ? new Followers.fromJson(json['followers'])
// //         : null;
// //     _genres = json['genres'].cast<String>();
// //     _href = json['href'];
// //     _id = json['id'];
// //     if (json['images'] != null) {
// //       _images = new List<Images>();
// //       json['images'].forEach((v) {
// //         _images.add(new Images.fromJson(v));
// //       });
// //     }
// //     _name = json['name'];
// //     _popularity = json['popularity'];
// //     _type = json['type'];
// //     _uri = json['uri'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     if (this._externalUrls != null) {
// //       data['external_urls'] = this._externalUrls.toJson();
// //     }
// //     if (this._followers != null) {
// //       data['followers'] = this._followers.toJson();
// //     }
// //     data['genres'] = this._genres;
// //     data['href'] = this._href;
// //     data['id'] = this._id;
// //     if (this._images != null) {
// //       data['images'] = this._images.map((v) => v.toJson()).toList();
// //     }
// //     data['name'] = this._name;
// //     data['popularity'] = this._popularity;
// //     data['type'] = this._type;
// //     data['uri'] = this._uri;
// //     return data;
// //   }
// // }
// //
// // class ExternalUrls {
// //   String _spotify;
// //
// //   ExternalUrls({String spotify}) {
// //     this._spotify = spotify;
// //   }
// //
// //   String get spotify => _spotify;
// //   set spotify(String spotify) => _spotify = spotify;
// //
// //   ExternalUrls.fromJson(Map<String, dynamic> json) {
// //     _spotify = json['spotify'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['spotify'] = this._spotify;
// //     return data;
// //   }
// // }
// //
// // class Followers {
// //   Null _href;
// //   int _total;
// //
// //   Followers({Null href, int total}) {
// //     this._href = href;
// //     this._total = total;
// //   }
// //
// //   Null get href => _href;
// //   set href(Null href) => _href = href;
// //   int get total => _total;
// //   set total(int total) => _total = total;
// //
// //   Followers.fromJson(Map<String, dynamic> json) {
// //     _href = json['href'];
// //     _total = json['total'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['href'] = this._href;
// //     data['total'] = this._total;
// //     return data;
// //   }
// // }
// //
// // class Images {
// //   int _height;
// //   String _url;
// //   int _width;
// //
// //   Images({int height, String url, int width}) {
// //     this._height = height;
// //     this._url = url;
// //     this._width = width;
// //   }
// //
// //   int get height => _height;
// //   set height(int height) => _height = height;
// //   String get url => _url;
// //   set url(String url) => _url = url;
// //   int get width => _width;
// //   set width(int width) => _width = width;
// //
// //   Images.fromJson(Map<String, dynamic> json) {
// //     _height = json['height'];
// //     _url = json['url'];
// //     _width = json['width'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['height'] = this._height;
// //     data['url'] = this._url;
// //     data['width'] = this._width;
// //     return data;
// //   }
// // }
// //
// // class ArtistResultRow extends StatelessWidget {
// //   Items result;
// //   Function onTap;
// //
// //   ArtistResultRow(Items result, Function onTap) {
// //     this.result = result;
// //     this.onTap = onTap;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return ListTile(
// //       leading: Image.network(result.images.last.url),
// //       title: Text(result.name),
// //     );
// //   }
// // }
//
// class ArtistResultRow extends StatelessWidget {
//   Items result;
//   Function onTap;
//
//   ArtistResultRow(Items result, Function onTap) {
//     this.result = result;
//     this.onTap = onTap;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Image.network(result.images.last.url),
//       title: Text(result.name),
//     );
//   }
// }
