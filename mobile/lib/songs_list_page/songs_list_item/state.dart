import 'package:fish_redux/fish_redux.dart';
import 'package:never_get_gray_mobile/music_player_page/play_controller_component/state.dart';

class SongsListItemState implements Cloneable<SongsListItemState> {
  int uid;
  String name;
  String artist;
  String album;
  String albumImg;
  String lyrics;
  int index;

  @override
  SongsListItemState clone() {
    var newState = SongsListItemState()
      ..uid = this.uid
      ..name = this.name
      ..artist = this.artist
      ..album = this.album
      ..albumImg = this.albumImg
      ..lyrics = this.lyrics
      ..index = 0;

    return newState;
  }
}
