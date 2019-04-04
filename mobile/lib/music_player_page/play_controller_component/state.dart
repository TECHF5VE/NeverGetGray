import 'package:fish_redux/fish_redux.dart';

import '../../unit/global_store.dart';

class PlayControllerState implements Cloneable<PlayControllerState> {
  PlayStatus playStatus;
  PlayQueueMode playQueueMode;
  int bufferedPercentage;
  int playingPosition;
  int contentLength;

  @override
  PlayControllerState clone() {
    return PlayControllerState()
      ..playStatus = this.playStatus
      ..playQueueMode = this.playQueueMode
      ..playingPosition = this.playingPosition
      ..bufferedPercentage = this.bufferedPercentage
      ..contentLength = this.contentLength;
  }
}
