import 'dart:async';

import 'package:fish_redux/fish_redux.dart';

class MusicPlayerState implements Cloneable<MusicPlayerState> {
  String coverUri;
  num imageAngle;
  Timer timer;

  @override
  MusicPlayerState clone() {
    var newState = MusicPlayerState()
      ..coverUri = this.coverUri
      ..imageAngle = this.imageAngle
      ..timer = this.timer;

    return newState;
  }
}
