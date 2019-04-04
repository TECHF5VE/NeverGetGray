import 'package:fish_redux/fish_redux.dart';
import 'package:never_get_gray_mobile/music_player_page/play_controller_component/state.dart';
import 'package:never_get_gray_mobile/play_list_page/play_list_item/state.dart';
import '../unit/global_store.dart';

class PlayListState implements Cloneable<PlayListState> {
  List<PlayListItemState> playListItems;

  @override
  PlayListState clone() {
    var newState = PlayListState()..playListItems = this.playListItems;

    return newState;
  }
}

class PlayControllerConnector
    extends ConnOp<PlayListState, PlayControllerState> {
  @override
  PlayControllerState get(PlayListState state) {
    return PlayControllerState()
      ..playStatus = GlobalStoreUtil.globalState.getState().playStatus
      ..playQueueMode = GlobalStoreUtil.globalState.getState().playQueueMode
      ..bufferedPercentage = GlobalStoreUtil.globalState.getState().bufferedPercentage
      ..contentLength = GlobalStoreUtil.globalState.getState().contentLength
      ..playingPosition = GlobalStoreUtil.globalState.getState().playingPosition;
  }

  @override
  void set(PlayListState state, PlayControllerState substate) {
    GlobalStoreUtil.globalState.dispatch(AppStateActionCreator.updatePlayStatus(substate.playStatus));
    GlobalStoreUtil.globalState.dispatch(AppStateActionCreator.updatePlayQueueMode(substate.playQueueMode));
  }
}
