import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CoverState> buildReducer() {
  return asReducer(
    <Object, Reducer<CoverState>> {
      CoverAction.updateTimer : _updateTimerReducer,
      CoverAction.updateImgAngle : _updaetImgAngleReducer,
    }
  );
}

CoverState _updateTimerReducer(CoverState state, Action action) {
  final newState = state.clone();
  newState.timer = action.payload;
  return newState;
}

CoverState _updaetImgAngleReducer(CoverState state, Action action) {
  final newState = state.clone();
  newState.imageAngle = action.payload;
  return newState;
}

