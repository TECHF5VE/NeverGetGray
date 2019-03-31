import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_cached_music_player/flutter_cached_music_player.dart';

import '../../unit/global_store.dart';

import 'action.dart';
import 'state.dart';

Effect<PlayControllerState> buildEffect() {
  return combineEffects(<Object, Effect<PlayControllerState>>{
    PlayControllerAction.onUpdatePlayStatus: _onPlayOrPause,

    // TODO: remove this after update fish-redux.
    PlayControllerAction.updatePlayStatusProxyWorkaround: (action, ctx) => {
          ctx.dispatch(PlayControllerActionCreator.updatePlayStatusAction(
              action.payload))
        },
  });
}

void _onPlayOrPause(Action action, Context<PlayControllerState> ctx) async {
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
