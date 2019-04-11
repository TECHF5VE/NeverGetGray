import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:never_get_gray_mobile/play_list_page/play_list_item/state.dart';
import 'package:never_get_gray_mobile/songs_list_page/songs_list_item/state.dart';

import '../../unit/global_store.dart';

class PlayControllerState extends AppSubState implements Cloneable<PlayControllerState> {
  PlayStatus playStatus;
  PlayQueueMode playQueueMode;
  int bufferedPercentage;
  int playingPosition;
  int contentLength;

  PlayListItemState playList;
  List<SongsListItemState> playQueue;
  int playIndex;

  bool isBufferd;

  Timer playingProgressTimer;

  PlayControllerState(AppState state) : super(state);

  @override
  PlayControllerState clone() {
    return PlayControllerState(this.appState)
      ..playStatus = this.playStatus
      ..playQueueMode = this.playQueueMode
      ..playingPosition = this.playingPosition
      ..bufferedPercentage = this.bufferedPercentage
      ..contentLength = this.contentLength

      ..playIndex = this.playIndex
      ..playQueue = this.playQueue
      ..playList = this.playList
      ..playingProgressTimer = this.playingProgressTimer;
  }
}

PlayControllerState initState() {
  return PlayControllerState(null)
    ..playIndex = -1
    ..playQueue = []
    ..playList = null
    ..contentLength = 1
    ..playingPosition = 0
    ..bufferedPercentage = 0
    ..playQueueMode = PlayQueueMode.Sequence
    ..playStatus = PlayStatus.Paused
    ..playingProgressTimer = null;
}
