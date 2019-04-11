import 'package:fish_redux/fish_redux.dart';

import '../music_player_page/cover_component/component.dart';
import '../music_player_page/play_controller_component/component.dart';

import '../music_player_page/cover_component/state.dart';
import '../music_player_page/play_controller_component/state.dart';
import '../unit/global_store.dart';

import 'state.dart';
import 'effect.dart';
import 'view.dart';

class MusicPlayerComponent extends Component<MusicPlayerState> {
  MusicPlayerComponent()
      : super(
          view: buildView,
          effect: buildEffect(),
          reducer: null,
          dependencies: Dependencies<MusicPlayerState>(
              adapter: null,
              slots: <String, Dependent<MusicPlayerState>>{
                'cover': CoverConnector() + CoverComponent(),
                'play_controller':
                    PlayControllerConnector() + PlayControllerComponent(),
              }),
        );
}

class CoverConnector extends ConnOp<MusicPlayerState, CoverState> {
  @override
  CoverState get(MusicPlayerState state) {
    final coverState = CoverState()
      ..coverUrl = state.coverUri
      ..imageAngle = state.imageAngle
      ..timer = state.timer;
    return coverState;
  }

  @override
  void set(MusicPlayerState state, CoverState substate) {
    state.coverUri = substate.coverUrl;
    state.imageAngle = substate.imageAngle;
    state.timer = substate.timer;
  }
}

class PlayControllerConnector
    extends ConnOp<MusicPlayerState, PlayControllerState> {
  @override
  PlayControllerState get(MusicPlayerState state) {
    return state.appState.playControllerState..appState = state.appState;
  }

  @override
  void set(MusicPlayerState state, PlayControllerState substate) {
    state.appState.playControllerState = substate;
  }
}
