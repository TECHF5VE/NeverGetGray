import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_cached_music_player/flutter_cached_music_player.dart';

import 'action.dart';
import 'state.dart';

import '../unit/global_store.dart';
import '../unit/playing_progress_timer_generator.dart';

Effect<MusicPlayerState> buildEffect() {
  return combineEffects(<Object, Effect<MusicPlayerState>> {
    Lifecycle.initState: _onAppear,
    Lifecycle.appear: _onAppear,
    Lifecycle.disappear: _onDisappearOrDispose,
    Lifecycle.dispose: _onDisappearOrDispose,
  });
}

void _onAppear(Action action, Context<MusicPlayerState> ctx) {
  if (GlobalStoreUtil.globalState.getState().playIndex != -1) {
    if (GlobalStoreUtil.globalState.getState().playingProgressTimer != null) {
      GlobalStoreUtil.globalState.getState().playingProgressTimer.cancel();
      GlobalStoreUtil.globalState
          .dispatch(AppStateActionCreator.updatePlayingProgressTimer(null));
    }
    generatePlayingProcessTimer(ctx);
  }
}

void _onDisappearOrDispose(Action action, Context<MusicPlayerState> ctx) {
  // if (GlobalStoreUtil.globalState.getState().playingProgressTimer != null) {
  //   GlobalStoreUtil.globalState.getState().playingProgressTimer.cancel();
  //   GlobalStoreUtil.globalState
  //       .dispatch(AppStateActionCreator.updatePlayingProgressTimer(null));
  //   FlutterCachedMusicPlayer.cancelBufferPercentStreamListen();
  // }
}