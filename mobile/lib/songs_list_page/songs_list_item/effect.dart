import 'package:fish_redux/fish_redux.dart';
import '../../unit/global_store.dart';
import '../../unit/network.dart';
import '../../unit/play_quque_generator.dart';
import '../../unit/playing_progress_timer_generator.dart';
import '../../unit/native_listener_util.dart';
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
  if (ctx.state.index != action.payload) {
    return;
  }

  final ip = GlobalStoreUtil.globalState.getState().ipAddr;
  final port = GlobalStoreUtil.globalState.getState().port;
  final authKey = GlobalStoreUtil.globalState.getState().authKey;

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

    if (GlobalStoreUtil.globalState.getState().playIndex != -1) {
      ctx.dispatch(SongsListItemActionCreator.updateIsPlayingAction(
          false, GlobalStoreUtil.globalState.getState().playIndex));
    }

    GlobalStoreUtil.globalState
        .dispatch(AppStateActionCreator.updatePlayIndexAction(ctx.state.index));
    GlobalStoreUtil.globalState
        .dispatch(AppStateActionCreator.updatePlayStatus(PlayStatus.Playing));

    if (GlobalStoreUtil.globalState.getState().currentPlayListUid !=
        GlobalStoreUtil.globalState.getState().playList.uid) {
      GlobalStoreUtil.globalState.dispatch(
          AppStateActionCreator.updateCurrentPlayListUidAction(
              GlobalStoreUtil.globalState.getState().playList.uid));
      PlayQueue.instance.clearHistory();
    }
    PlayQueue.instance.generatePlayQueue();

    await FlutterCachedMusicPlayer.stop();
    await FlutterCachedMusicPlayer.prepare(response.data['data']['stream_url']);
    await FlutterCachedMusicPlayer.play();

    if (GlobalStoreUtil.globalState.getState().playingProgressTimer != null) {
      GlobalStoreUtil.globalState.getState().playingProgressTimer.cancel();
      GlobalStoreUtil.globalState.dispatch(
          AppStateActionCreator.updatePlayingProgressTimerAction(null));
      FlutterCachedMusicPlayer.cancelBufferPercentStreamListen();
    }
    generatePlayingProcessTimer(ctx);
    // print(GlobalStoreUtil.globalState.getState().playingProgressTimer);
    listenToBufferPercentStream(ctx);

    ctx.dispatch(SongsListItemActionCreator.updateIsPlayingAction(
        true, ctx.state.index));

    AppProvider.appBroadcast(
        ctx.context,
        PlayControllerActionCreator.updatePlayStatusWorkAroundAction(
            PlayStatus.Playing));
  } catch (e) {
    print(e);
  }
}
