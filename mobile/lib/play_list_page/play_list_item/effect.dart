import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_cached_music_player/flutter_cached_music_player.dart';
import '../../songs_list_page/page.dart' as songsListPage;
import '../../unit/global_store.dart';
import '../../unit/native_listener_util.dart';
import '../../unit/playing_progress_timer_generator.dart';

import 'action.dart';
import 'state.dart';

Effect<PlayListItemState> buildEffect() {
  return combineEffects(<Object, Effect<PlayListItemState>>{
    PlayListItemAction.onNavigateToSongsList: _onNavigateToSongsList,
  });
}

void _onNavigateToSongsList(
    Action action, Context<PlayListItemState> ctx) async {
  GlobalStoreUtil.globalState
      .dispatch(AppStateActionCreator.updatePlayListAction(ctx.state));
  await Navigator.of(ctx.context)
      .push(MaterialPageRoute<Map<String, String>>(
    builder: (buildCtx) =>
        songsListPage.SongsListPage().buildPage(<String, dynamic>{
          'state': ctx.state,
        }),
  ))
      .then((value) async {
    if (GlobalStoreUtil.globalState.getState().playingProgressTimer != null) {
      GlobalStoreUtil.globalState.getState().playingProgressTimer.cancel();
      GlobalStoreUtil.globalState
          .dispatch(AppStateActionCreator.updatePlayingProgressTimerAction(null));
      await FlutterCachedMusicPlayer.cancelBufferPercentStreamListen();
    }

    listenToBufferPercentStream(ctx);

    if (GlobalStoreUtil.globalState.getState().playIndex != -1) {
      generatePlayingProcessTimer(ctx);
    }
  });
}
