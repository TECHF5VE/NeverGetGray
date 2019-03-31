import 'package:fish_redux/fish_redux.dart';
import '../../unit/global_store.dart';
import '../../unit/network.dart';
import '../../music_player_page/play_controller_component/action.dart';

import 'action.dart';
import 'state.dart';

import 'package:flutter_cached_music_player/flutter_cached_music_player.dart';

Effect<SongsListItemState> buildEffect() {
  return combineEffects(<Object, Effect<SongsListItemState>>{
    SongsListItemAction.onPlaySong: _onPlaySong
  });
}

void _onPlaySong(Action action, Context<SongsListItemState> ctx) async {
  GlobalStoreUtil.globalState
      .dispatch(AppStoreActionCreate.updatePlayIndexAction(ctx.state.index));

  final ip = GlobalStoreUtil.globalState.getState().ipAddr;
  final port = GlobalStoreUtil.globalState.getState().port;
  final authKey = GlobalStoreUtil.globalState.getState().authKey;

  try {
    if (ctx.state.albumImg == '') {
      final response = await NetWorkUnit.get(ip, 'songs/${ctx.state.uid}', port, {
        'auth_key': authKey,
      });

      print(response);

      if (response.data['code'] == '200') {
        ctx.dispatch(SongsListItemActionCreator.udpateAlbumImg(
            response.data['data']['album_img']));
        ctx.dispatch(SongsListItemActionCreator.udpateLyrics(
            response.data['data']['lyrics']));
      }
    }

    final response = await NetWorkUnit.get(ip, 'stream/${ctx.state.uid}', port, {
      'auth_key': authKey,
    });

    print(response);
    await FlutterCachedMusicPlayer.prepare(response.data['data']['stream_url']);
    await FlutterCachedMusicPlayer.play();

    GlobalStoreUtil.globalState.dispatch(AppStoreActionCreate.updatePlayStatus(PlayStatus.Playing));
    AppProvider.appBroadcast(ctx.context, PlayControllerActionCreator.updatePlayStatusWorkAroundAction(PlayStatus.Playing));
    // ctx.dispatch(PlayControllerActionCreator.updatePlayStatus(PlayStatus.Playing));
  } catch (e) {
    print(e);
  }
}
