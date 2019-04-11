import 'package:fish_redux/fish_redux.dart';
import '../../unit/global_store.dart';
import '../../unit/network.dart';
import '../../unit/play_quque_generator.dart';
import '../../unit/playing_progress_timer_generator.dart';
import '../../music_player_page/play_controller_component/action.dart';

import 'action.dart';
import 'state.dart';

import 'package:flutter_cached_music_player/flutter_cached_music_player.dart';

Effect<SongsListItemState> buildEffect() {
  return combineEffects(<Object, Effect<SongsListItemState>>{
    SongsListItemAction.onPlaySong: _onPlaySong,
  });
}

void _onPlaySong(Action action, Context<SongsListItemState> ctx) async {
  // TODO: reset related info when change playlist.
  if (ctx.state.index != action.payload) {
    return;
  }

  final ip = ctx.state.appState.ipAddr;
  final port = ctx.state.appState.port;
  final authKey = ctx.state.appState.authKey;

  try {
    if (ctx.state.albumImg == '') {
      final response =
          await NetWorkUnit.get(ip, 'songs/${ctx.state.uid}', port, {
        'auth_key': authKey,
      });

      print(response);

      if (response.data['code'] == '200') {
        ctx.dispatch(SongsListItemActionCreator.updateAlbumImgAction(
            response.data['data']['album_img'], ctx.state.index));
        ctx.dispatch(SongsListItemActionCreator.updateLyricsAction(
          response.data['data']['lyrics'],
          ctx.state.index,
        ));
      }
    }

    final response =
        await NetWorkUnit.get(ip, 'stream/${ctx.state.uid}', port, {
      'auth_key': authKey,
    });

    print(response);

    final controllerState = ctx.state.appState.playControllerState;
    if (controllerState.playIndex != -1) {
      ctx.dispatch(SongsListItemActionCreator.updateIsPlayingAction(
          false, controllerState.playIndex));
    }

    ctx.dispatch(
        PlayControllerActionCreator.updatePlayIndexAction(ctx.state.index));
    ctx.dispatch(
        PlayControllerActionCreator.updatePlayStatusAction(PlayStatus.Playing));

    PlayQueue.instance.clearHistory();
    PlayQueue.instance.generatePlayQueue(ctx.state);

    await FlutterCachedMusicPlayer.stop();
    await FlutterCachedMusicPlayer.prepare(response.data['data']['stream_url']);
    await FlutterCachedMusicPlayer.play();

    if (controllerState.playingProgressTimer != null) {
      controllerState.playingProgressTimer.cancel();
      ctx.dispatch(
          PlayControllerActionCreator.updatePlayingProgressTimerReducer(null));
    }
    generatePlayingProcessTimer(ctx);
    print(controllerState.playingProgressTimer);

    FlutterCachedMusicPlayer.listenToBufferPercentStream((percentage) async {
      print('percentage: $percentage');
      ctx.dispatch(PlayControllerActionCreator.updateBufferedPercentageAction(
          percentage));
      if (percentage >= 100) {
        await FlutterCachedMusicPlayer.cancelBufferPercentStreamListen();
      }
    });

    ctx.dispatch(SongsListItemActionCreator.updateIsPlayingAction(
        true, ctx.state.index));

    ctx.dispatch(
        PlayControllerActionCreator.updatePlayStatusAction(PlayStatus.Playing));
  } catch (e) {
    print(e);
  }
}
