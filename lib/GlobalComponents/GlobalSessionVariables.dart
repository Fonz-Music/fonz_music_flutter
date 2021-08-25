
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestSpotifyApi.dart';

import 'Objects/Artist.dart';
import 'Objects/Playlist.dart';
import 'Objects/Track.dart';

var hostSessionIdGlobal = "";

// active song
ActiveSongDecoder activeSongNowPlaying;
var updateActiveSong = true;

// top songs
List<Track> topSongs;
var updateTopSongs = true;
var tempTracks = [
  Track("Boyfriend", [" Big Time Rush"], "1rKBOL9kJfX1Y4C3QaOvRH", "https://i.scdn.co/image/ab67616d0000b27350acd1f66ebd5b84630c7129"),
  Track.withUrl("Is It True", ["Tame Impala"], "6RZmhpvukfyeSURhf4kZ0d", "https://i.scdn.co/image/ab67616d0000b27358267bd34420a00d5cf83a49", "https://open.spotify.com/track/6RZmhpvukfyeSURhf4kZ0d"),
  Track.withUrl("The Spirit Of Radio", ["Rush"], "4e9hUiLsN4mx61ARosFi7p", "https://i.scdn.co/image/ab67616d0000b27306c0d7ebcabad0c39b566983", "https://open.spotify.com/track/4e9hUiLsN4mx61ARosFi7p"),
  Track.withUrl("Limelight", ["Rush"], "0K6yUnIKNsFtfIpTgGtcHm", "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),
  Track.withUrl("Prune, You Talk Funny", [" Gus Dapperton"], "6sHCvZe1PHrOAuYlwTLNH4",  "https://i.scdn.co/image/ab67616d0000b273ba8dea5129b6e43b59fadad7", "https://open.spotify.com/track/6sHCvZe1PHrOAuYlwTLNH4"),
  Track.withUrl("Supalonely", [" BENEE"], "3GZoWLVbmxcBys6g0DLFLf",   "https://i.scdn.co/image/ab67616d0000b2734bd20e01d00de4b35b61f5f7",  "https://open.spotify.com/track/3GZoWLVbmxcBys6g0DLFLf"),
  Track.withUrl("Post Humorous", [" Gus Dapperton"], "0yb9DKhu0xA0h0qvKOHVwu",   "https://i.scdn.co/image/ab67616d0000b2731dc1bd83254e89b474ca496b",  "https://open.spotify.com/track/0yb9DKhu0xA0h0qvKOHVwu"),
  Track.withUrl("I\'m Just Snacking", [" Gus Dapperton"], "6413UUgINHbZsCJeJBFlmT",    "https://i.scdn.co/image/ab67616d0000b27303c5191d01d37d5c795697df",  "https://open.spotify.com/track/6413UUgINHbZsCJeJBFlmT"),
  Track.withUrl("Palms (with Channel Tres)", [" Gus Dapperton Channel Tres"], "0Lskej1hiep1PKXoz7KhyO", "https://i.scdn.co/image/ab67616d0000b273fd9c5111af2d35d22fb4a512",  "https://open.spotify.com/track/0Lskej1hiep1PKXoz7KhyO"),
  Track.withUrl("Somewhere (feat. Gus Dapperton)", [" Surf Mesa Gus Dapperton"], "0bmQ5H9mHFzRnJ4ZntylFg",  "https://i.scdn.co/image/ab67616d0000b273ba3286704e1aec6a762ab144",  "https://open.spotify.com/track/0bmQ5H9mHFzRnJ4ZntylFg"),
  Track.withUrl("Medicine", [" Gus Dapperton"], "7lLtAjBc4Fkaw0FkBQWlSX",   "https://i.scdn.co/image/ab67616d0000b2731dc1bd83254e89b474ca496b",  "https://open.spotify.com/track/7lLtAjBc4Fkaw0FkBQWlSX"),
  Track.withUrl("I\'m On Fire", [" Gus Dapperton"], "0lhcKPk0fppMAnFUt3QNy7",   "https://i.scdn.co/image/ab67616d0000b273ada32af03830941f2b510bd9", "https://open.spotify.com/track/0lhcKPk0fppMAnFUt3QNy7"),];

List<Artist> topArtists;
var updateTopArtists = true;
var tempArtists = [
  Artist("Red Hot Chili Peppers", "0L8ExT028jH3ddEcZwqJJ5", "https://i.scdn.co/image/89bc3c14aa2b4f250033ffcf5f322b2a553d9331"),
  Artist( "Kings of Leon", "2qk9voo8llSGYcZ6xrBzKx", "https://i.scdn.co/image/168a281f4a0b1c2c61acb010239ead4710a234a3"),
  Artist( "Circa Waves", "6hl5k4gLl1p3sjhHcb57t2", "https://i.scdn.co/image/4a8d60073c6ce7007ac43a4807b36f0abd381028"),
  Artist("Hippo Campus", "1btWGBz4Uu1HozTwb2Lm8A",  "https://i.scdn.co/image/ab6761610000e5eb220b2af522d5044b93fc678e"),
  Artist("COIN", "0ZxZlO7oWCSYMXhehpyMvE", "https://i.scdn.co/image/ab6761610000e5eb8a331b3acc328de052617020"),
  Artist("alt-J", "3XHO7cRUPCLOr6jwp8vsx5",  "https://i.scdn.co/image/7ac54cbec2f1b3f5f1b7f6fc23acb9d00c70fb51"),
  Artist("BENEE", "0Cp8WN4V8Tu4QJQwCN5Md4", "https://i.scdn.co/image/cf1265cb1c2c35d253cbbac9b1489bc181322ed3"),
  Artist("girl in red", "3uwAm6vQy7kWPS2bciKWx9", "https://i.scdn.co/image/ebff5a127cf8fbb20deb9bbcd02cfea64a660bef"),
  Artist("Rush", "2Hkut4rAAyrQxRdof7FVJq", "https://i.scdn.co/image/6fdfa7c623d77d5900e69eef2443340e3493a4bf")
];

List<Playlist> topPlaylists;
var updateTopPlaylists = true;
var tempPlaylists =
[
  Playlist("This Is Rush", "https://i.scdn.co/image/ab67706f0000000336834b90af842ac737f7dac3",  "37i9dQZF1DX9E92APFiTvV", 50),
  Playlist("memoryLane",  "https://i.scdn.co/image/ab67706c0000bebbbbb8672f1afbe3add6554550",  "3sRM90oyy8Zul8iF3Cg3RF", 21),
  Playlist("beautifulEscape",   "https://i.scdn.co/image/ab67706c0000bebb12bc8c494507c2f6550b919b", "4d2ObNuTa7AIMJY8TGvLDB", 31),
  Playlist("manifest destiny", "https://i.scdn.co/image/ab67706c0000bebb802a02183d45115fc2639cb6",  "4TOUWjjIiwBNXj82cLnltq", 43),
  Playlist("malibuNinetyTwo", "https://i.scdn.co/image/ab67706c0000bebb0e65fceaffd297b0f3f14756",  "6rqm7IuR0DRbktih6FV9jm", 83)

];

List<Track> tracksFromPlaylist;
var updateTracksFromPlaylist = true;

List<Track> tracksFromArtist;
var updateTracksFromArtist = true;