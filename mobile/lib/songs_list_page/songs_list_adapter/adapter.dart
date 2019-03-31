import 'package:fish_redux/fish_redux.dart';

import '../../play_list_page/play_list_item/state.dart';
import '../songs_list_item/component.dart';

class SongsListAdapter extends DynamicFlowAdapter<PlayListItemState> {
  SongsListAdapter()
    : super(
      pool: <String, Component<Object>> {
        'songsListItem' : SongsListItemComponent(),
      },
      connector: _SongsListConnector(),
      reducer: null,
      effect: null,
    );
}

class _SongsListConnector implements Connector<PlayListItemState, List<ItemBean>> {
  @override
  List<ItemBean> get(PlayListItemState state) {
    if (state.songs?.isNotEmpty == true) {
      return state.songs.asMap().map((index, value) {
        value.index = index + 1; 
        return MapEntry(index, ItemBean('songsListItem', value));
      }).values.toList(growable: true);
      // return state.songs
      //             .map((data, index) => ItemBean('songsListItem', data))
      //             .toList(growable: true);

    } else {
      return [];
    }
  }

  @override
  void set(PlayListItemState state, List<ItemBean> substate) {}
}
