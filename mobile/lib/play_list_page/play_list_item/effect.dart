import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_cached_music_player/flutter_cached_music_player.dart';
import 'package:never_get_gray_mobile/music_player_page/play_controller_component/action.dart';
import '../../unit/playing_progress_timer_generator.dart';
import 'package:never_get_gray_mobile/app_route.dart';

import 'action.dart';
import 'state.dart';

Effect<PlayListItemState> buildEffect() {
  return combineEffects(<Object, Effect<PlayListItemState>>{
    PlayListItemAction.onNavigateToSongsList: _onNavigateToSongsList,
  });
}

void _onNavigateToSongsList(
    Action action, Context<PlayListItemState> ctx) async {
  // GlobalStoreUtil.globalState
  //     .dispatch(AppStateActionCreator.updatePlayListAction(ctx.state));

  ctx.dispatch(AppStateActionCreator.updatePlayListItemAction(ctx.state));
  ctx.dispatch(PlayControllerActionCreator.updatePlayListAction(ctx.state));
  // ctx.dispatch()

  await Navigator.of(ctx.context)
      .push(MaterialPageRoute<Map<String, String>>(
    builder: (buildCtx) =>
      AppRoute.global.buildPage(RoutePath.songsList, null)
  ))
      .then((value) async {
    final controllerState = ctx.state.appState.playControllerState;
    if (controllerState.playingProgressTimer != null) {
      controllerState.playingProgressTimer.cancel();
      ctx.dispatch(PlayControllerActionCreator.updatePlayingProgressTimerReducer(null));
      await FlutterCachedMusicPlayer.cancelBufferPercentStreamListen();
    }

    FlutterCachedMusicPlayer.listenToBufferPercentStream((percentage) async {
      print('percentage: $percentage');
      ctx.dispatch(PlayControllerActionCreator.updateBufferedPercentageAction(percentage));

      if (percentage >= 100) {
        await FlutterCachedMusicPlayer.cancelBufferPercentStreamListen();
      }
    });

    if (controllerState.playIndex != -1) {
      generatePlayingProcessTimer(ctx);
    }
  });
}
