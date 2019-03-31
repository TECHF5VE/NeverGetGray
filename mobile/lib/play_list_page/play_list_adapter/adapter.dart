import 'package:fish_redux/fish_redux.dart';
// import 'package:never_get_gray_mobile/play_list_page/play_list_item/state.dart';

import '../state.dart';
import 'effect.dart';
import '../play_list_item/component.dart';

class PlayListAdapter extends DynamicFlowAdapter<PlayListState> {
  PlayListAdapter()
      : super(
          pool: <String, Component<Object>>{
            'playListItem': PlayListItemComponent(),
          },
          connector: _PlayListConnector(),
          reducer: null,
          effect: buildEffect(),
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
        // ItemBean('playListItem', PlayListItemState()..songs=[]..name='test1'..uid=0),
        // ItemBean('playListItem', PlayListItemState()..songs=[]..name='test2'..uid=1),
      ];
    }
  }

  @override
  void set(PlayListState state, List<ItemBean> substate) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return null;
  }
}
