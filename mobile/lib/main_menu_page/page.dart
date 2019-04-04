import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';
import 'effect.dart';
import 'reducer.dart';
import 'stfstate.dart';

import '../play_list_page/component.dart';
import '../setting_page/component.dart';
import '../music_player_page/component.dart';

class MainMenuPage extends Page<PageState, Map<String, String>> {
  @override
  PageStfState createState() =>  PageStfState();

  MainMenuPage()
    : super(
      initState: initState,
      effect: buildEffect(),
      reducer: buildReducer(),
      view: buildView,
      dependencies : Dependencies<PageState>(
        adapter: null,
        slots: <String, Dependent<PageState>>{
          'music_player': MusicPlayerConnector() + MusicPlayerComponent(),
          'play_list' : PlayListConnector() + PlayListComponent(),
          'setting' : SettingConnector() + SettingComponent(),
        }
      ),
    );
}
