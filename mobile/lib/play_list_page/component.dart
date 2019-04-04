import 'package:fish_redux/fish_redux.dart';

import '../music_player_page/play_controller_component/component.dart';
import 'play_list_adapter/adapter.dart';

import 'view.dart';
import 'reducer.dart';
import 'effect.dart';
import 'state.dart';

class PlayListComponent extends Component<PlayListState> {
  PlayListComponent()
    : super(
      view: buildView,
      effect: buildEffect(),
      reducer: buildReducer(),
      dependencies : Dependencies<PlayListState>(
        adapter: PlayListAdapter(),
        slots: <String, Dependent<PlayListState>>{
          'play_controller' : PlayControllerConnector() + PlayControllerComponent(),
        }
      ),
    );
}
