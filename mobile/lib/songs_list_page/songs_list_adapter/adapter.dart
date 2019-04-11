import 'package:fish_redux/fish_redux.dart';
import 'package:never_get_gray_mobile/songs_list_page/songs_list_item/state.dart';

import '../../play_list_page/play_list_item/state.dart';
import '../songs_list_item/component.dart';

class SongsListAdapter extends DynamicFlowAdapter<PlayListItemState> {
  SongsListAdapter()
      : super(
          pool: <String, Component<Object>>{
            'songsListItem': SongsListItemComponent(),
          },
          connector: _SongsListConnector(),
          reducer: null,
          effect: null,
        );
}

class _SongsListConnector extends ConnOp<PlayListItemState, List<ItemBean>> {
  @override
  List<ItemBean> get(PlayListItemState state) {
    if (state.songs?.isNotEmpty == true) {
      return state.songs
          .map((elem) =>
              ItemBean('songsListItem', elem..appState = state.appState))
          .toList(growable: true);
    } else {
      return [];
    }
  }

  @override
  void set(PlayListItemState state, List<ItemBean> substate) {
    print(state.appState.playControllerState.playIndex);
    state.songs =
        substate.map<SongsListItemState>((elem) => elem.data).toList();
  }
}
