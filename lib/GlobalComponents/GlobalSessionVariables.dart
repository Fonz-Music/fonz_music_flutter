
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestSpotifyApi.dart';

import 'Objects/Track.dart';

var hostSessionIdGlobal = "";

// active song
ActiveSongDecoder activeSongNowPlaying;
var updateActiveSong = true;

// top songs
List<Track> topSongs;
var updateTopSongs = true;