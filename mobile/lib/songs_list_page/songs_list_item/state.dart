import 'package:fish_redux/fish_redux.dart';

class SongsListItemState implements Cloneable<SongsListItemState> {
  int uid;
  String name;
  String artist;
  String album;
  String albumImg;
  String lyrics;

  @override
  SongsListItemState clone() {
    var newState = SongsListItemState()
      ..uid = this.uid
      ..name = this.name
      ..artist = this.artist
      ..album = this.album
      ..albumImg = this.albumImg
      ..lyrics = this.lyrics;

    return newState;
  }
}
