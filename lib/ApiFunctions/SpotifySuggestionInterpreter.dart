// Generated decoder for the spotify search response

class SpotifySearchResponse {
  Tracks _tracks;

  SpotifySearchResponse({Tracks tracks}) {
    this._tracks = tracks;
  }

  Tracks get tracks => _tracks;
  set tracks(Tracks tracks) => _tracks = tracks;

  SpotifySearchResponse.fromJson(Map<String, dynamic> json) {
    _tracks =
        json['tracks'] != null ? new Tracks.fromJson(json['tracks']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._tracks != null) {
      data['tracks'] = this._tracks.toJson();
    }
    return data;
  }
}

class Tracks {
  String _href;
  List<Items> _items;
  int _limit;
  String _next;
  int _offset;
  Null _previous;
  int _total;

  Tracks(
      {String href,
      List<Items> items,
      int limit,
      String next,
      int offset,
      Null previous,
      int total}) {
    this._href = href;
    this._items = items;
    this._limit = limit;
    this._next = next;
    this._offset = offset;
    this._previous = previous;
    this._total = total;
  }

  String get href => _href;
  set href(String href) => _href = href;
  List<Items> get items => _items;
  set items(List<Items> items) => _items = items;
  int get limit => _limit;
  set limit(int limit) => _limit = limit;
  String get next => _next;
  set next(String next) => _next = next;
  int get offset => _offset;
  set offset(int offset) => _offset = offset;
  Null get previous => _previous;
  set previous(Null previous) => _previous = previous;
  int get total => _total;
  set total(int total) => _total = total;

  Tracks.fromJson(Map<String, dynamic> json) {
    _href = json['href'];
    if (json['items'] != null) {
      _items = new List<Items>();
      json['items'].forEach((v) {
        _items.add(new Items.fromJson(v));
      });
    }
    _limit = json['limit'];
    _next = json['next'];
    _offset = json['offset'];
    _previous = json['previous'];
    _total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this._href;
    if (this._items != null) {
      data['items'] = this._items.map((v) => v.toJson()).toList();
    }
    data['limit'] = this._limit;
    data['next'] = this._next;
    data['offset'] = this._offset;
    data['previous'] = this._previous;
    data['total'] = this._total;
    return data;
  }
}

class Items {
  Album _album;
  List<Artists> _artists;
  int _discNumber;
  int _durationMs;
  bool _explicit;
  ExternalIds _externalIds;
  ExternalUrls _externalUrls;
  String _href;
  String _id;
  bool _isLocal;
  bool _isPlayable;
  String _name;
  int _popularity;
  String _previewUrl;
  int _trackNumber;
  String _type;
  String _uri;

  Items(
      {Album album,
      List<Artists> artists,
      int discNumber,
      int durationMs,
      bool explicit,
      ExternalIds externalIds,
      ExternalUrls externalUrls,
      String href,
      String id,
      bool isLocal,
      bool isPlayable,
      String name,
      int popularity,
      String previewUrl,
      int trackNumber,
      String type,
      String uri}) {
    this._album = album;
    this._artists = artists;
    this._discNumber = discNumber;
    this._durationMs = durationMs;
    this._explicit = explicit;
    this._externalIds = externalIds;
    this._externalUrls = externalUrls;
    this._href = href;
    this._id = id;
    this._isLocal = isLocal;
    this._isPlayable = isPlayable;
    this._name = name;
    this._popularity = popularity;
    this._previewUrl = previewUrl;
    this._trackNumber = trackNumber;
    this._type = type;
    this._uri = uri;
  }

  Album get album => _album;
  set album(Album album) => _album = album;
  List<Artists> get artists => _artists;
  set artists(List<Artists> artists) => _artists = artists;
  int get discNumber => _discNumber;
  set discNumber(int discNumber) => _discNumber = discNumber;
  int get durationMs => _durationMs;
  set durationMs(int durationMs) => _durationMs = durationMs;
  bool get explicit => _explicit;
  set explicit(bool explicit) => _explicit = explicit;
  ExternalIds get externalIds => _externalIds;
  set externalIds(ExternalIds externalIds) => _externalIds = externalIds;
  ExternalUrls get externalUrls => _externalUrls;
  set externalUrls(ExternalUrls externalUrls) => _externalUrls = externalUrls;
  String get href => _href;
  set href(String href) => _href = href;
  String get id => _id;
  set id(String id) => _id = id;
  bool get isLocal => _isLocal;
  set isLocal(bool isLocal) => _isLocal = isLocal;
  bool get isPlayable => _isPlayable;
  set isPlayable(bool isPlayable) => _isPlayable = isPlayable;
  String get name => _name;
  set name(String name) => _name = name;
  int get popularity => _popularity;
  set popularity(int popularity) => _popularity = popularity;
  String get previewUrl => _previewUrl;
  set previewUrl(String previewUrl) => _previewUrl = previewUrl;
  int get trackNumber => _trackNumber;
  set trackNumber(int trackNumber) => _trackNumber = trackNumber;
  String get type => _type;
  set type(String type) => _type = type;
  String get uri => _uri;
  set uri(String uri) => _uri = uri;

  Items.fromJson(Map<String, dynamic> json) {
    _album = json['album'] != null ? new Album.fromJson(json['album']) : null;
    if (json['artists'] != null) {
      _artists = new List<Artists>();
      json['artists'].forEach((v) {
        _artists.add(new Artists.fromJson(v));
      });
    }
    _discNumber = json['disc_number'];
    _durationMs = json['duration_ms'];
    _explicit = json['explicit'];
    _externalIds = json['external_ids'] != null
        ? new ExternalIds.fromJson(json['external_ids'])
        : null;
    _externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    _href = json['href'];
    _id = json['id'];
    _isLocal = json['is_local'];
    _isPlayable = json['is_playable'];
    _name = json['name'];
    _popularity = json['popularity'];
    _previewUrl = json['preview_url'];
    _trackNumber = json['track_number'];
    _type = json['type'];
    _uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._album != null) {
      data['album'] = this._album.toJson();
    }
    if (this._artists != null) {
      data['artists'] = this._artists.map((v) => v.toJson()).toList();
    }
    data['disc_number'] = this._discNumber;
    data['duration_ms'] = this._durationMs;
    data['explicit'] = this._explicit;
    if (this._externalIds != null) {
      data['external_ids'] = this._externalIds.toJson();
    }
    if (this._externalUrls != null) {
      data['external_urls'] = this._externalUrls.toJson();
    }
    data['href'] = this._href;
    data['id'] = this._id;
    data['is_local'] = this._isLocal;
    data['is_playable'] = this._isPlayable;
    data['name'] = this._name;
    data['popularity'] = this._popularity;
    data['preview_url'] = this._previewUrl;
    data['track_number'] = this._trackNumber;
    data['type'] = this._type;
    data['uri'] = this._uri;
    return data;
  }
}

class Album {
  String _albumType;
  List<Artists> _artists;
  ExternalUrls _externalUrls;
  String _href;
  String _id;
  List<Images> _images;
  String _name;
  String _releaseDate;
  String _releaseDatePrecision;
  int _totalTracks;
  String _type;
  String _uri;

  Album(
      {String albumType,
      List<Artists> artists,
      ExternalUrls externalUrls,
      String href,
      String id,
      List<Images> images,
      String name,
      String releaseDate,
      String releaseDatePrecision,
      int totalTracks,
      String type,
      String uri}) {
    this._albumType = albumType;
    this._artists = artists;
    this._externalUrls = externalUrls;
    this._href = href;
    this._id = id;
    this._images = images;
    this._name = name;
    this._releaseDate = releaseDate;
    this._releaseDatePrecision = releaseDatePrecision;
    this._totalTracks = totalTracks;
    this._type = type;
    this._uri = uri;
  }

  String get albumType => _albumType;
  set albumType(String albumType) => _albumType = albumType;
  List<Artists> get artists => _artists;
  set artists(List<Artists> artists) => _artists = artists;
  ExternalUrls get externalUrls => _externalUrls;
  set externalUrls(ExternalUrls externalUrls) => _externalUrls = externalUrls;
  String get href => _href;
  set href(String href) => _href = href;
  String get id => _id;
  set id(String id) => _id = id;
  List<Images> get images => _images;
  set images(List<Images> images) => _images = images;
  String get name => _name;
  set name(String name) => _name = name;
  String get releaseDate => _releaseDate;
  set releaseDate(String releaseDate) => _releaseDate = releaseDate;
  String get releaseDatePrecision => _releaseDatePrecision;
  set releaseDatePrecision(String releaseDatePrecision) =>
      _releaseDatePrecision = releaseDatePrecision;
  int get totalTracks => _totalTracks;
  set totalTracks(int totalTracks) => _totalTracks = totalTracks;
  String get type => _type;
  set type(String type) => _type = type;
  String get uri => _uri;
  set uri(String uri) => _uri = uri;

  Album.fromJson(Map<String, dynamic> json) {
    _albumType = json['album_type'];
    if (json['artists'] != null) {
      _artists = new List<Artists>();
      json['artists'].forEach((v) {
        _artists.add(new Artists.fromJson(v));
      });
    }
    _externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    _href = json['href'];
    _id = json['id'];
    if (json['images'] != null) {
      _images = new List<Images>();
      json['images'].forEach((v) {
        _images.add(new Images.fromJson(v));
      });
    }
    _name = json['name'];
    _releaseDate = json['release_date'];
    _releaseDatePrecision = json['release_date_precision'];
    _totalTracks = json['total_tracks'];
    _type = json['type'];
    _uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['album_type'] = this._albumType;
    if (this._artists != null) {
      data['artists'] = this._artists.map((v) => v.toJson()).toList();
    }
    if (this._externalUrls != null) {
      data['external_urls'] = this._externalUrls.toJson();
    }
    data['href'] = this._href;
    data['id'] = this._id;
    if (this._images != null) {
      data['images'] = this._images.map((v) => v.toJson()).toList();
    }
    data['name'] = this._name;
    data['release_date'] = this._releaseDate;
    data['release_date_precision'] = this._releaseDatePrecision;
    data['total_tracks'] = this._totalTracks;
    data['type'] = this._type;
    data['uri'] = this._uri;
    return data;
  }
}

class Artists {
  ExternalUrls _externalUrls;
  String _href;
  String _id;
  String _name;
  String _type;
  String _uri;

  Artists(
      {ExternalUrls externalUrls,
      String href,
      String id,
      String name,
      String type,
      String uri}) {
    this._externalUrls = externalUrls;
    this._href = href;
    this._id = id;
    this._name = name;
    this._type = type;
    this._uri = uri;
  }

  ExternalUrls get externalUrls => _externalUrls;
  set externalUrls(ExternalUrls externalUrls) => _externalUrls = externalUrls;
  String get href => _href;
  set href(String href) => _href = href;
  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get type => _type;
  set type(String type) => _type = type;
  String get uri => _uri;
  set uri(String uri) => _uri = uri;

  Artists.fromJson(Map<String, dynamic> json) {
    _externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    _href = json['href'];
    _id = json['id'];
    _name = json['name'];
    _type = json['type'];
    _uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._externalUrls != null) {
      data['external_urls'] = this._externalUrls.toJson();
    }
    data['href'] = this._href;
    data['id'] = this._id;
    data['name'] = this._name;
    data['type'] = this._type;
    data['uri'] = this._uri;
    return data;
  }
}

class ExternalUrls {
  String _spotify;

  ExternalUrls({String spotify}) {
    this._spotify = spotify;
  }

  String get spotify => _spotify;
  set spotify(String spotify) => _spotify = spotify;

  ExternalUrls.fromJson(Map<String, dynamic> json) {
    _spotify = json['spotify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spotify'] = this._spotify;
    return data;
  }
}

class Images {
  int _height;
  String _url;
  int _width;

  Images({int height, String url, int width}) {
    this._height = height;
    this._url = url;
    this._width = width;
  }

  int get height => _height;
  set height(int height) => _height = height;
  String get url => _url;
  set url(String url) => _url = url;
  int get width => _width;
  set width(int width) => _width = width;

  Images.fromJson(Map<String, dynamic> json) {
    _height = json['height'];
    _url = json['url'];
    _width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this._height;
    data['url'] = this._url;
    data['width'] = this._width;
    return data;
  }
}

class ExternalIds {
  String _isrc;

  ExternalIds({String isrc}) {
    this._isrc = isrc;
  }

  String get isrc => _isrc;
  set isrc(String isrc) => _isrc = isrc;

  ExternalIds.fromJson(Map<String, dynamic> json) {
    _isrc = json['isrc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isrc'] = this._isrc;
    return data;
  }
}
