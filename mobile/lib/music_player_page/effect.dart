import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_cached_music_player/flutter_cached_music_player.dart';
import 'package:never_get_gray_mobile/music_player_page/play_controller_component/action.dart';

import 'state.dart';
import 'package:never_get_gray_mobile/unit/playing_progress_timer_generator.dart';

Effect<MusicPlayerState> buildEffect() {
  return combineEffects(<Object, Effect<MusicPlayerState>> {
    Lifecycle.initState: _onAppear,
    Lifecycle.appear: _onAppear,
    Lifecycle.disappear: _onDisappearOrDispose,
    Lifecycle.dispose: _onDisappearOrDispose,
  });
}

void _onAppear(Action action, Context<MusicPlayerState> ctx) {
  if (ctx.state.appState.playControllerState.playIndex != -1) {
    if (ctx.state.appState.playControllerState.playingProgressTimer != null) {
      ctx.state.appState.playControllerState.playingProgressTimer.cancel();
      // GlobalStoreUtil.globalState
      //     .dispatch(AppStateActionCreator.updatePlayingProgressTimer(null));
      ctx.dispatch(PlayControllerActionCreator.updatePlayingProgressTimerReducer(null));
    }
    generatePlayingProcessTimer(ctx);
  }
}

void _onDisappearOrDispose(Action action, Context<MusicPlayerState> ctx) {
  if (ctx.state.appState.playControllerState.playingProgressTimer != null) {
    ctx.state.appState.playControllerState.playingProgressTimer.cancel();
    // GlobalStoreUtil.globalState
    //     .dispatch(AppStateActionCreator.updatePlayingProgressTimer(null));
    ctx.dispatch(PlayControllerActionCreator.updatePlayingProgressTimerReducer(null));
    FlutterCachedMusicPlayer.cancelBufferPercentStreamListen();
  }
}