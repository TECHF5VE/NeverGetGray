import 'package:fish_redux/fish_redux.dart';
import 'package:never_get_gray_mobile/music_player_page/play_controller_component/state.dart';
import '../../songs_list_page/songs_list_item/state.dart';
import '../../unit/global_store.dart';

class PlayListItemState extends AppSubState implements Cloneable<PlayListItemState> {
  int uid;
  String name;
  List<SongsListItemState> songs;

  PlayListItemState(AppState state) : super(state);

  @override
  PlayListItemState clone() {
    final newState = PlayListItemState(this.appState)
      ..uid = this.uid
      ..name = this.name
      ..songs = this.songs;

    return newState;
  }
}

PlayListItemState initState(Map<String, dynamic> args) {
  // final oldState = args['state'] as PlayListItemState;
  // return oldState;
  return PlayListItemState(null)
    ..uid = -1
    ..name = ''
    ..songs = [];
}

class PlayControllerConnector
    extends ConnOp<PlayListItemState, PlayControllerState> {
  @override
  PlayControllerState get(PlayListItemState state) {
    return state.appState?.playControllerState;
  }

  @override
  void set(PlayListItemState state, PlayControllerState substate) {
    state.appState.playControllerState = substate;
  }
}
