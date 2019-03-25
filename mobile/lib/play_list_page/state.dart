import 'package:fish_redux/fish_redux.dart';
import 'package:never_get_gray_mobile/music_player_page/play_controller_component/state.dart';
import 'package:never_get_gray_mobile/play_list_page/play_list_item/state.dart';

class PlayListState implements Cloneable<PlayListState> {
  List<PlayListItemState> playListItems;

  @override
  PlayListState clone() {
    var newState = PlayListState()
    ..playListItems = this.playListItems;

    return newState;
  }
}

class PlayControllerConnector extends ConnOp<PlayListState, PlayControllerState> {
  @override
  PlayControllerState get(PlayListState state) {
    return PlayControllerState();
  }

  @override
  void set(PlayListState state, PlayControllerState substate) {}
}
