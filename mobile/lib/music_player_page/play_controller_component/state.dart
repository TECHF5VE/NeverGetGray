import 'package:fish_redux/fish_redux.dart';

import '../../unit/global_store.dart';

class PlayControllerState implements Cloneable<PlayControllerState> {
  PlayStatus playStatus;

  @override
  PlayControllerState clone() {
    return PlayControllerState()..playStatus = this.playStatus;
  }
}
