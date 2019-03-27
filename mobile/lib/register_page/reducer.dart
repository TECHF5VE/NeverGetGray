import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RegisterState> buildReducer() {
  return asReducer(
    <Object, Reducer<RegisterState>> {
      RegisterAction.inputRefresh: _inputRefreshReducer,
      RegisterAction.registerSuccess: _registerSuccessReducer,
      RegisterAction.registerPending: _registerPendingReducer,
      RegisterAction.registerError: _registerErrorReducer,
    }
  );
}

RegisterState _inputRefreshReducer(RegisterState state, Action action) {
  return state.clone();
}

RegisterState _registerSuccessReducer(RegisterState state, Action action) {
  final newState = state.clone();
  newState.isWaiting = false;
  return newState;
}

RegisterState _registerErrorReducer(RegisterState state, Action action) {
  final newState = state.clone();
  newState.isWaiting = false;
  return newState;
}

RegisterState _registerPendingReducer(RegisterState state, Action action) {
  final newState = state.clone();
  newState.isWaiting = true;
  return newState;
}
