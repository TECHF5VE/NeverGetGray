import 'package:fish_redux/fish_redux.dart';
import 'package:never_get_gray_mobile/music_player_page/play_controller_component/action.dart';
import 'package:never_get_gray_mobile/play_list_page/play_list_item/state.dart';

import 'action.dart';
import 'state.dart';

import '../unit/global_store.dart';
import '../unit/playing_progress_timer_generator.dart';


Effect<PlayListState> buildEffect() {
  return combineEffects(<Object, Effect<PlayListState>> {
    Lifecycle.initState: _onAppear,
    Lifecycle.appear: _onAppear,
  });
}

void _onAppear(Action action, Context<PlayListState> ctx) async {
  final controllerState = ctx.state.appState.playControllerState;
  if (controllerState.playIndex != -1) {
    if (controllerState.playingProgressTimer != null) {
      controllerState.playingProgressTimer.cancel();
      ctx.dispatch(PlayControllerActionCreator.updatePlayingProgressTimerReducer(null));
    }
    generatePlayingProcessTimer(ctx);
  }
}

