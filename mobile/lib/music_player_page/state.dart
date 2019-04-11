import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:never_get_gray_mobile/unit/global_store.dart';

class MusicPlayerState extends AppSubState implements Cloneable<MusicPlayerState> {
  String coverUri;
  num imageAngle;
  Timer timer;

  MusicPlayerState(AppState state) : super(state);

  @override
  MusicPlayerState clone() {
    var newState = MusicPlayerState(this.appState)
      ..coverUri = this.coverUri
      ..imageAngle = this.imageAngle
      ..timer = this.timer;

    return newState;
  }
}
