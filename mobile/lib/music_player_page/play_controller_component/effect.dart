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

    // TODO: remove this after update fish-redux.
    PlayControllerAction.updatePlayStatusProxyWorkaround: (action, ctx) => {
          ctx.dispatch(PlayControllerActionCreator.updatePlayStatusAction(
              action.payload))
        },
  });
}

void _onUpdatePlayQueueMode(Action action, Context<PlayControllerState> ctx) {
  final mode = action.payload as PlayQueueMode;

  PlayQueue.instance.generatePlayQueue();

  ctx.dispatch(PlayControllerActionCreator.updatePlayQueueModeAction(mode));
}

void _onPlayOrPause(Action action, Context<PlayControllerState> ctx) async {
  if (GlobalStoreUtil.globalState.getState().playIndex == -1) {
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
  if (GlobalStoreUtil.globalState.getState().playIndex == -1) {
    return;
  }

  final nextSong = PlayQueue.instance.nextSongInfo;

  final ip = GlobalStoreUtil.globalState.getState().ipAddr;
  final port = GlobalStoreUtil.globalState.getState().port;
  final authKey = GlobalStoreUtil.globalState.getState().authKey;

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

    GlobalStoreUtil.globalState
        .dispatch(AppStoreActionCreate.updatePlayIndexAction(nextSong.index));
    GlobalStoreUtil.globalState
        .dispatch(AppStoreActionCreate.updatePlayStatus(PlayStatus.Playing));

    await FlutterCachedMusicPlayer.stop();
    await FlutterCachedMusicPlayer.prepare(response.data['data']['stream_url']);
    await FlutterCachedMusicPlayer.play();
  } catch (e) {
    print(e);
  }
}

void _onPlayLastSong(Action action, Context<PlayControllerState> ctx) async {
  if (GlobalStoreUtil.globalState.getState().playIndex == -1) {
    return;
  }

  final nextSong = PlayQueue.instance.lastSongInfo;

  final ip = GlobalStoreUtil.globalState.getState().ipAddr;
  final port = GlobalStoreUtil.globalState.getState().port;
  final authKey = GlobalStoreUtil.globalState.getState().authKey;

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

    GlobalStoreUtil.globalState
        .dispatch(AppStoreActionCreate.updatePlayIndexAction(nextSong.index));
    GlobalStoreUtil.globalState
        .dispatch(AppStoreActionCreate.updatePlayStatus(PlayStatus.Playing));

    await FlutterCachedMusicPlayer.stop();
    await FlutterCachedMusicPlayer.prepare(response.data['data']['stream_url']);
    await FlutterCachedMusicPlayer.play();
  } catch (e) {
    print(e);
  }
}
