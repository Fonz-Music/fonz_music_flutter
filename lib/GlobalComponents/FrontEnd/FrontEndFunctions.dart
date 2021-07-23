

String convertArtistArrayToString(String artists) {
  var newString = artists.replaceAll('[', '').replaceAll(']', '');
  if (newString.contains(" ", 0)) {
    newString.replaceFirst(" ", "");
  }
  return newString;
}