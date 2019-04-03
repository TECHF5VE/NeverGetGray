import 'package:fish_redux/fish_redux.dart';

import '../../unit/global_store.dart';

class PlayControllerState implements Cloneable<PlayControllerState> {
  PlayStatus playStatus;
  PlayQueueMode playQueueMode;

  @override
  PlayControllerState clone() {
    return PlayControllerState()
      ..playStatus = this.playStatus
      ..playQueueMode = this.playQueueMode;
  }
}
