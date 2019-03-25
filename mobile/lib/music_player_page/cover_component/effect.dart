import 'dart:async';

import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'action.dart';

Effect<CoverState> buildEffect() {
  return combineEffects(<Object, Effect<CoverState>> {
    CoverAction.onPlayOrPause : _onPlayOrPause,
  });
}

void _onPlayOrPause(Action action, Context<CoverState> ctx) {
  if (action.payload == true) {
    final timer = Timer.periodic(const Duration(milliseconds: 50), (t) {
      ctx.dispatch(CoverActionCreator.updateImgAngle((ctx.state.imageAngle + 1.0 / 360) % 360.0));
    });
    ctx.dispatch(CoverActionCreator.updateTimerAction(timer));
  } else {
    final timer = ctx.state.timer;
    timer.cancel();
    ctx.dispatch(CoverActionCreator.updateTimerAction(null));
    ctx.dispatch(CoverActionCreator.updateImgAngle(0));
  }
}
