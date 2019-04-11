import 'package:fish_redux/fish_redux.dart';
import 'package:never_get_gray_mobile/play_list_page/play_list_item/state.dart';
import 'package:never_get_gray_mobile/unit/global_store.dart';

class SongListConnector extends ConnOp<AppState, PlayListItemState> {
  @override
  PlayListItemState get(AppState state) {
    // print(state.playControllerState.playIndex);
    return state.songsListState..appState = state;
  }

  @override
  void set(AppState state, PlayListItemState subState) {
    // print(state.playControllerState.playIndex);
    state.songsListState = subState;
    for (var i = 0; i < state.pageState.playListItems.length; i++) {
      if (state.pageState.playListItems[i].uid == subState.uid) {
        state.pageState.playListItems[i] = subState;
      }
    }
  }
}
