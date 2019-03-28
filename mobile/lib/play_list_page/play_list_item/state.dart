import 'package:fish_redux/fish_redux.dart';
import '../../songs_list_page/songs_list_item/state.dart';

class PlayListItemState implements Cloneable<PlayListItemState> {
  int uid;
  String name;
  List<SongsListItemState> songs;

  @override
  PlayListItemState clone() {
    final newState = PlayListItemState()
    ..uid = this.uid
    ..name = this.name
    ..songs = this.songs;

    return newState;
  }
}
