import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';
import 'reducer.dart';

import '../music_player_page/cover_component/component.dart';
import '../music_player_page/play_controller_component/component.dart';

class MainMenuPage extends Page<PageState, Map<String, dynamic>> {
  MainMenuPage()
    : super(
      initState: initState,
      effect: null,
      reducer: buildReducer(),
      view: buildView,
      dependencies : Dependencies<PageState>(
        adapter: null,
        slots: <String, Dependent<PageState>>{
          'cover' : CoverConnector() + CoverComponent(),
          'play_controller' :PlayControllerConnector() + PlayControllerComponent(),
        }
      ),
      middlewares : []
    );
}
