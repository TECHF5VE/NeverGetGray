import 'dart:async';

import 'package:fish_redux/fish_redux.dart';

class CoverState implements Cloneable<CoverState> {
  String coverUrl;
  num imageAngle;
  Timer timer;
 
  @override
  CoverState clone() {
    var newState = CoverState()
    ..coverUrl = this.coverUrl
    ..imageAngle = this.imageAngle
    ..timer = this.timer;

    return newState;
  }
}
