import 'package:fish_redux/fish_redux.dart';
import 'package:never_get_gray_mobile/unit/global_store.dart';

class SongsListItemState extends AppSubState implements Cloneable<SongsListItemState> {
  int uid;
  String name;
  String artist;
  String album;
  String albumImg;
  String lyrics;
  int index;
  bool isPlaying;

  SongsListItemState(AppState state) : super(state);

  @override
  SongsListItemState clone() {
    var newState = SongsListItemState(this.appState)
      ..uid = this.uid
      ..name = this.name
      ..artist = this.artist
      ..album = this.album
      ..albumImg = this.albumImg
      ..lyrics = this.lyrics
      ..index = this.index
      ..isPlaying = this.isPlaying;

    return newState;
  }
}
