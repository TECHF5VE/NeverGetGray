import 'package:fish_redux/fish_redux.dart';
import 'package:never_get_gray_mobile/music_player_page/play_controller_component/state.dart';
import 'package:never_get_gray_mobile/play_list_page/play_list_item/state.dart';
import 'package:never_get_gray_mobile/unit/global_store.dart';

class PlayListState extends AppSubState implements Cloneable<PlayListState> {
  List<PlayListItemState> playListItems;

  PlayListState(AppState state) : super(state);

  @override
  PlayListState clone() {
    var newState = PlayListState(this.appState)
      ..playListItems = this.playListItems;

    return newState;
  }
}

class PlayControllerConnector
    extends ConnOp<PlayListState, PlayControllerState> {
  @override
  PlayControllerState get(PlayListState state) {
    return state.appState.playControllerState..appState = state.appState;
  }

  @override
  void set(PlayListState state, PlayControllerState substate) {
    state.appState.playControllerState = substate;
  }
}
