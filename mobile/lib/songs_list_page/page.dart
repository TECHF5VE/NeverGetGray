import 'package:fish_redux/fish_redux.dart';

import 'songs_list_adapter/adapter.dart';
import 'view.dart';
import '../play_list_page/play_list_item/state.dart';
import '../music_player_page/play_controller_component/component.dart';

class SongsListPage extends Page<PlayListItemState, Map<String, dynamic>> {
  SongsListPage()
      : super(
          initState: initState,
          effect: null,
          reducer: null,
          view: buildView,
          dependencies: Dependencies<PlayListItemState>(
              adapter: SongsListAdapter(),
              slots: <String, Dependent<PlayListItemState>>{
                'play_controller':
                    PlayControllerConnector() + PlayControllerComponent(),
              }),
        );
}
