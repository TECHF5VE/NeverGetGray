import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_cached_music_player/flutter_cached_music_player.dart';

import '../../unit/global_store.dart';
import '../../unit/play_quque_generator.dart';
import '../../unit/network.dart';

import 'action.dart';
import 'state.dart';

Effect<PlayControllerState> buildEffect() {
  return combineEffects(<Object, Effect<PlayControllerState>>{
    PlayControllerAction.onUpdatePlayStatus: _onPlayOrPause,
    PlayControllerAction.onUpdatePlayQueueMode: _onUpdatePlayQueueMode,
    PlayControllerAction.onPlayNextSong: _onPlayNextSong,
    PlayControllerAction.onPlayLastSong: _onPlayLastSong,
  });
}

void _onUpdatePlayQueueMode(Action action, Context<PlayControllerState> ctx) {
  final mode = action.payload as PlayQueueMode;

  PlayQueue.instance.generatePlayQueue(ctx.state);

  ctx.dispatch(PlayControllerActionCreator.updatePlayQueueModeAction(mode));
}

void _onPlayOrPause(Action action, Context<PlayControllerState> ctx) async {
  if (ctx.state.playIndex == -1) {
    return;
  }

  final playStatus = action.payload as PlayStatus;
  switch (playStatus) {
    case PlayStatus.Loading:
      break;
    case PlayStatus.Paused:
      await FlutterCachedMusicPlayer.pause();
      break;
    case PlayStatus.Playing:
      await FlutterCachedMusicPlayer.play();
      break;
    default:
      break;
  }

  ctx.dispatch(PlayControllerActionCreator.updatePlayStatusAction(playStatus));
}

Future _onPlayNextSong(Action action, Context<PlayControllerState> ctx) async {
  if (ctx.state.playIndex == -1) {
    return;
  }

  final nextSong = PlayQueue.instance.getNextSongInfo(ctx.state);

  final ip = ctx.state.appState.ipAddr;
  final port = ctx.state.appState.port;
  final authKey = ctx.state.appState.authKey;

  try {
    if (nextSong.albumImg == '') {
      final response =
          await NetWorkUnit.get(ip, 'songs/${nextSong.uid}', port, {
        'auth_key': authKey,
      });

      // if (response.data['code'] == '200') {
      //   ctx.dispatch(SongsListItemActionCreator.udpateAlbumImg(
      //       response.data['data']['album_img']));
      //   ctx.dispatch(SongsListItemActionCreator.udpateLyrics(
      //       response.data['data']['lyrics']));
      // }
    }

    final response = await NetWorkUnit.get(ip, 'stream/${nextSong.uid}', port, {
      'auth_key': authKey,
    });

    // GlobalStoreUtil.globalState
    //     .dispatch(AppStateActionCreator.updatePlayIndexAction(nextSong.index));
    // todo: update SongsListItem playing status.
    ctx.dispatch(PlayControllerActionCreator.updatePlayIndexAction(nextSong.index));
    ctx.dispatch(PlayControllerActionCreator.updatePlayStatusAction(PlayStatus.Playing));

    await FlutterCachedMusicPlayer.stop();
    await FlutterCachedMusicPlayer.prepare(response.data['data']['stream_url']);
    await FlutterCachedMusicPlayer.play();
  } catch (e) {
    print(e);
  }
}

void _onPlayLastSong(Action action, Context<PlayControllerState> ctx) async {
  if (ctx.state.playIndex == -1) {
    return;
  }

  final nextSong = PlayQueue.instance.getLastSongInfo(ctx.state);

  final ip = ctx.state.appState.ipAddr;
  final port = ctx.state.appState.port;
  final authKey = ctx.state.appState.authKey;

  try {
    if (nextSong.albumImg == '') {
      final response =
          await NetWorkUnit.get(ip, 'songs/${nextSong.uid}', port, {
        'auth_key': authKey,
      });

      print(response);

      // if (response.data['code'] == '200') {
      //   ctx.dispatch(SongsListItemActionCreator.udpateAlbumImg(
      //       response.data['data']['album_img']));
      //   ctx.dispatch(SongsListItemActionCreator.udpateLyrics(
      //       response.data['data']['lyrics']));
      // }
    }

    final response = await NetWorkUnit.get(ip, 'stream/${nextSong.uid}', port, {
      'auth_key': authKey,
    });

    print(response);

    // GlobalStoreUtil.globalState
    //     .dispatch(AppStateActionCreator.updatePlayIndexAction(nextSong.index));
    // GlobalStoreUtil.globalState
    //     .dispatch(AppStateActionCreator.updatePlayStatus(PlayStatus.Playing));

    ctx.dispatch(PlayControllerActionCreator.updatePlayIndexAction(nextSong.index));
    ctx.dispatch(PlayControllerActionCreator.updatePlayStatusAction(PlayStatus.Playing));
    
    await FlutterCachedMusicPlayer.stop();
    await FlutterCachedMusicPlayer.prepare(response.data['data']['stream_url']);
    await FlutterCachedMusicPlayer.play();
  } catch (e) {
    print(e);
  }
}
