
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestSpotifyApi.dart';

import 'Objects/Artist.dart';
import 'Objects/Playlist.dart';
import 'Objects/Track.dart';

var hostSessionIdGlobal = "";
var groupFromCoaster = "";

// active song
ActiveSongDecoder activeSongNowPlaying;
var updateActiveSong = true;

// top songs
List<Track> topSongs;
var updateTopSongs = true;
var tempTracks = [
  Track.withUrl("Chanel", ["Frank Ocean"], "6Nle9hKrkL1wQpwNfEkxjh", "https://i.scdn.co/image/ab67616d0000b273a0b780c23fc3c19bd412b234", "https://open.spotify.com/track/6Nle9hKrkL1wQpwNfEkxjh"),
  Track.withUrl("Do Me a Favour", ["Arctic Monkeys"], "13NCxLOlvQ4Tnexgfp03Gs", "https://i.scdn.co/image/ab67616d0000b2730c8ac83035e9588e8ad34b90", "https://open.spotify.com/track/13NCxLOlvQ4Tnexgfp03Gs"),
  Track.withUrl("Pacifier", ["Catfish and the Bottlemen"], "1rcu88dzWE5GyqtpuWvd0C", "https://i.scdn.co/image/ab67616d0000b273b87da477ad10e87b09b88d1e", "https://open.spotify.com/track/1rcu88dzWE5GyqtpuWvd0C"),
  Track.withUrl("Verdigris", ["Gus Dapperton"], "0praNEF55GE8iZca1tC8BM", "https://i.scdn.co/image/ab67616d0000b27361d8be1be46d21609f68d476", "https://open.spotify.com/track/0praNEF55GE8iZca1tC8BM"),
  Track.withUrl("What They Want", ["Russ"], "3pndPhlQWjuSoXhcIIdBjv", "https://i.scdn.co/image/ab67616d0000b273cb045e684adce8d49ada4045", "https://open.spotify.com/track/3pndPhlQWjuSoXhcIIdBjv"),
  Track.withUrl("Take My Breath", ["The Weeknd"], "6OGogr19zPTM4BALXuMQpF", "https://i.scdn.co/image/ab67616d0000b2733c041e53cb5c38b6de03e758", "https://open.spotify.com/track/6OGogr19zPTM4BALXuMQpF"),
  Track.withUrl("Digital Love", ["Daft Punk"], "2VEZx7NWsZ1D0eJ4uv5Fym", "https://i.scdn.co/image/ab67616d0000b273b33d46dfa2635a47eebf63b2", "https://open.spotify.com/track/2VEZx7NWsZ1D0eJ4uv5Fym"),
  Track.withUrl("Bonny", ["Prefab Sprout"], "6XGup1vnoRarqS5Eb0zeUc", "https://i.scdn.co/image/ab67616d0000b273e40c4c9d5f19d2ab9886a534", "https://open.spotify.com/track/6XGup1vnoRarqS5Eb0zeUc"),
  Track.withUrl("ooh La", ["The Kooks"], "6xqCTPxYnRf8X0p6N5Vw2T", "https://i.scdn.co/image/ab67616d0000b2736e8b31b2e7cec192c603eece", "https://open.spotify.com/track/6xqCTPxYnRf8X0p6N5Vw2T"),
  Track.withUrl("Hello?", ["Clairo", "Rejjie Snow"], "7qwt4xUIqQWCu1DJf96g2k", "https://i.scdn.co/image/ab67616d0000b273bf94e27360806b5aa5025f93", "https://open.spotify.com/track/7qwt4xUIqQWCu1DJf96g2k"),
  Track.withUrl("A Fool Moon Night", ["THE KOXX"], "6c7JQdDL94DF8ECGCwT3zG", "https://i.scdn.co/image/ab67616d0000b27300e62f490dd62b191d6c6874", "https://open.spotify.com/track/6c7JQdDL94DF8ECGCwT3zG"),
  Track.withUrl("Glue", ["Bicep"], "2aJDlirz6v2a4HREki98cP", "https://i.scdn.co/image/ab67616d0000b273d4322a9004288009f6da2975", "https://open.spotify.com/track/2aJDlirz6v2a4HREki98cP"),
  Track.withUrl("Losing It", ["FISHER"], "6ho0GyrWZN3mhi9zVRW7xi", "https://i.scdn.co/image/ab67616d0000b2739367c1ee2eec0bf3a04b4868", "https://open.spotify.com/track/6ho0GyrWZN3mhi9zVRW7xi"),
  Track.withUrl("Believe What I Say", ["Kanye West"], "73uxnSsFMeJ15POpd3zgrV", "https://i.scdn.co/image/ab67616d0000b2736ba1cffc9b2c5469503430b3", "https://open.spotify.com/track/73uxnSsFMeJ15POpd3zgrV"),
  Track.withUrl("Anseo (Single Mix)", ["Denise Chaila", "Jafaris"], "6DW0XcQeWW9s4SU5cStQqc", "https://i.scdn.co/image/ab67616d0000b273f0ad7b153c7ca8ea32579a20", "https://open.spotify.com/track/6DW0XcQeWW9s4SU5cStQqc"),
  Track.withUrl("I Still Haven't Found What I'm Looking For", ["U2"], "6wpGqhRvJGNNXwWlPmkMyO", "https://i.scdn.co/image/ab67616d0000b273b7bea3d01f04e6d0408d2afe", "https://open.spotify.com/track/6wpGqhRvJGNNXwWlPmkMyO"),
  Track.withUrl("A.D.H.D", ["Kendrick Lamar"], "2Fw5S2gaOSZzdN5dFoC2dj", "https://i.scdn.co/image/ab67616d0000b273eddb2639b74ac6c202032ebe", "https://open.spotify.com/track/2Fw5S2gaOSZzdN5dFoC2dj"),
  Track.withUrl("Zombie", ["The Cranberries"], "7EZC6E7UjZe63f1jRmkWxt", "https://i.scdn.co/image/ab67616d0000b27372d481a5999197ef5f42f796", "https://open.spotify.com/track/7EZC6E7UjZe63f1jRmkWxt"),
  Track.withUrl("That Funny Feeling", ["Bo Burnham"], "7uCq4vBPffjaTMlE8EQzJD", "https://i.scdn.co/image/ab67616d0000b2732853b5ea06ddc676b337c389", "https://open.spotify.com/track/7uCq4vBPffjaTMlE8EQzJD"),
  Track.withUrl("Bonkers", ["Dizzee Rascal","Armand Van Helden"], "6ddQ5KCkvCggk3j6KdA0zL", "https://i.scdn.co/image/ab67616d0000b2736f754c78ad0a1cb7fa2d6c4f", "https://open.spotify.com/track/6ddQ5KCkvCggk3j6KdA0zL"),
  ];

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