import 'package:fish_redux/fish_redux.dart';
import 'package:never_get_gray_mobile/play_list_page/play_list_item/state.dart';

import '../state.dart';
import '../play_list_item/component.dart';
import '../../main_menu_page/state.dart';

class PlayListAdapter extends DynamicFlowAdapter<PlayListState> {
  PlayListAdapter()
    : super(
      pool: <String, Component<Object>> {
        'playListItem' : PlayListItemComponent(),
      },
      connector: _PlayListConnector(),
      reducer: null,
    );
}

class _PlayListConnector implements Connector<PlayListState, List<ItemBean>> {
  @override
  List<ItemBean> get(PlayListState state) {
    if (state.playListItems?.isNotEmpty == true) {
      return state.playListItems
                  .map((data) => ItemBean('playListItem', data))
                  .toList(growable: true);
    } else {
      return <ItemBean>[
        ItemBean('playListItem', PlayListItemState()..album='https://i.imgur.com/70sJIg7.png'..name='test1'..uid='test1'),
        ItemBean('playListItem', PlayListItemState()..album='https://i.imgur.com/dNrc79d.jpg'..name='test2'..uid='test2'),
      ];
    }
  }

  @override
  void set(PlayListState state, List<ItemBean> substate) {}
}
