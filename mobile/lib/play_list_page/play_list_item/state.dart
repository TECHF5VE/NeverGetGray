import 'package:fish_redux/fish_redux.dart';

class PlayListItemState implements Cloneable<PlayListItemState> {
  String uid;
  String name;
  String album;
  String artist;

  @override
  PlayListItemState clone() {
    final newState = PlayListItemState()
    ..uid = this.uid
    ..name = this.name
    ..album = this.album
    ..artist = this.artist;

    return newState;
  }
}
