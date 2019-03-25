import 'dart:async';

import 'package:fish_redux/fish_redux.dart';

enum CoverAction {
  onPlayOrPause,
  updateTimer,
  updateImgAngle,
}

class CoverActionCreator {
  static Action onPlayOrPauseAction(bool toPlay) => Action(CoverAction.onPlayOrPause, payload: toPlay);
  static Action updateTimerAction(Timer timer) => Action(CoverAction.updateTimer, payload: timer);
  static Action updateImgAngle(num angle) => Action(CoverAction.updateImgAngle, payload: angle);
}
