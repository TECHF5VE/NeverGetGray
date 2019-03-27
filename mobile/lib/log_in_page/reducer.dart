import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LogInState> buildReducer() {
  return asReducer(<Object, Reducer<LogInState>>{
    LogInAction.logInSuccess: _logInSuccessReducer,
    LogInAction.logInPending: _logInPendingReducer,
    LogInAction.logInError: _logInErrorReducer,
    LogInAction.updateLogInInfo: _updateLogInInfo,
    LogInAction.initFromStorage: _initFromStorage,
  });
}

LogInState _logInSuccessReducer(LogInState state, Action action) {
  final newState = state.clone();
  newState.isWaiting = false;
  return newState;
}

LogInState _logInPendingReducer(LogInState state, Action action) {
  final newState = state.clone();
  newState.isWaiting = true;
  return newState;
}

LogInState _logInErrorReducer(LogInState state, Action action) {
  final newState = state.clone();
  newState.isWaiting = false;
  return newState;
}

LogInState _updateLogInInfo(LogInState state, Action action) {
  return state.clone();
}

LogInState _initFromStorage(LogInState state, Action action) {
  final data = action.payload as Map<String, String>;
  final newState = state.clone();
  newState.userName.text = data['userName'];
  newState.password.text = data['password'];
  newState.serverIP.text = data['ipAddr'];
  newState.serverPort.text = data['port'];
  return newState;
}
