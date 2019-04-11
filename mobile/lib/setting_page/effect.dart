import 'package:fish_redux/fish_redux.dart';
import 'package:never_get_gray_mobile/music_player_page/play_controller_component/action.dart';

import 'action.dart';
import 'state.dart';

Effect<SettingState> buildEffect() {
  return combineEffects(<Object, Effect<SettingState>> {
    Lifecycle.initState: _onAppear,
    Lifecycle.appear: _onAppear,
  });
}

void _onAppear(Action action, Context<SettingState> ctx) async {
  final controllerState = ctx.state.appState.playControllerState;
  if (controllerState.playIndex != -1) {
    if (controllerState.playingProgressTimer != null) {
      controllerState.playingProgressTimer.cancel();
      ctx.dispatch(PlayControllerActionCreator.updatePlayingProgressTimerReducer(null));
    }
  }
}

