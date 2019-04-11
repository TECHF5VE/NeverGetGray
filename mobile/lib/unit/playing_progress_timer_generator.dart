import 'package:fish_redux/fish_redux.dart';
import 'dart:async';

import 'package:flutter_cached_music_player/flutter_cached_music_player.dart';
import './global_store.dart';
import '../music_player_page/play_controller_component/action.dart';

void generatePlayingProcessTimer(dynamic ctx) {
  final timer = Timer.periodic(const Duration(milliseconds: 1000), (t) async {
    // print('waiting...');
    final playPosition = await FlutterCachedMusicPlayer.currentPlayingPosition;
    final contentLength = await FlutterCachedMusicPlayer.musicContentLength;

    // print("playPosition $playPosition, contentLength $contentLength");

    ctx.dispatch(
        PlayControllerActionCreator.updatePlayingPositionAction(playPosition));
    ctx.dispatch(
        PlayControllerActionCreator.updateContentLengthAction(contentLength));

    ctx.dispatch(
        PlayControllerActionCreator.updatePlayingPositionAction(playPosition));
    ctx.dispatch(
        PlayControllerActionCreator.updateContentLengthAction(contentLength));

    if (playPosition >= contentLength) {
      t.cancel();
    }
  });

  ctx.dispatch(
      PlayControllerActionCreator.updatePlayingProgressTimerReducer(timer));
}
