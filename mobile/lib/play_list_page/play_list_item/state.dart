import 'package:fish_redux/fish_redux.dart';
import 'package:never_get_gray_mobile/music_player_page/play_controller_component/state.dart';
import '../../songs_list_page/songs_list_item/state.dart';
import '../../unit/global_store.dart';

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

PlayListItemState initState(Map<String, dynamic> args) {
  final oldState = args['state'] as PlayListItemState;
  return oldState;
}

class PlayControllerConnector
    extends ConnOp<PlayListItemState, PlayControllerState> {
  @override
  PlayControllerState get(PlayListItemState state) {
    return PlayControllerState()
      ..playStatus = GlobalStoreUtil.globalState.getState().playStatus
      ..playQueueMode = GlobalStoreUtil.globalState.getState().playQueueMode
      ..bufferedPercentage = GlobalStoreUtil.globalState.getState().bufferedPercentage
      ..contentLength = GlobalStoreUtil.globalState.getState().contentLength
      ..playingPosition = GlobalStoreUtil.globalState.getState().playingPosition;
  }

  @override
  void set(PlayListItemState state, PlayControllerState substate) {
    GlobalStoreUtil.globalState.dispatch(AppStateActionCreator.updatePlayStatus(substate.playStatus));
    GlobalStoreUtil.globalState.dispatch(AppStateActionCreator.updatePlayQueueMode(substate.playQueueMode));
  }
}
