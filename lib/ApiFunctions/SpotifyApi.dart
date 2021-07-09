class SpotifyAPI {
  static Future<UserTopArtistsResponse> getUserTopArtists() async {
    Dio dio = new Dio();
    try {
      dio.options.headers = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
      Response response =
          await dio.get('https://api.spotify.com/v1/me/top/artists');
      if (response.statusCode == 200) {
        UserTopArtistsResponse.fromJson(json.decode(response.data.toString()));
      } else {
        log(response.statusCode.toString());
        log(response.statusMessage);
        log(response.data.toString());
        throw new SpotifyException(SpotifyExceptionTypes.ARTISTS);
      }
    } on SpotifyException catch (e) {
      rethrow;
    }
  }

  static Future<UserTopTracksResponse> getUserTopTracks() async {
    Dio dio = new Dio();
    dio.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    try {
      Response response =
          await dio.get('https://api.spotify.com/v1/me/top/tracks');
      if (response.statusCode == 200) {
        UserTopTracksResponse.fromJson(json.decode(response.data.toString()));
      } else {
        log(response.statusCode.toString());
        log(response.statusMessage);
        log(response.data.toString());
        throw new SpotifyException(SpotifyExceptionTypes.TRACKS);
      }
    } on SpotifyException catch (e) {
      rethrow;
    }
  }
}
