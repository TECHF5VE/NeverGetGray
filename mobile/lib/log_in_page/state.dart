import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';

import 'package:never_get_gray_mobile/unit/global_store.dart';

class LogInState implements Cloneable<LogInState> {
  TextEditingController userName;
  TextEditingController password;
  TextEditingController serverIP;
  TextEditingController serverPort;
  String authKey;

  bool isWaiting;

  @override
  LogInState clone() {
    var newState = LogInState()
      ..userName = this.userName
      ..password = this.password
      ..serverIP = this.serverIP
      ..serverPort = this.serverPort
      ..isWaiting = this.isWaiting
      ..authKey = this.authKey;
    return newState;
  }
}

LogInState initState(Map<String, dynamic> args) {
  return LogInState()
    ..userName = (TextEditingController()
      ..text = '')
    ..password = (TextEditingController()
      ..text = '')
    ..serverIP = (TextEditingController()
      ..text = 'https://www.easy-mock.com/mock/5c9b493193944f200184f1d0/api')
    ..serverPort = (TextEditingController()
      ..text = '80')
    ..isWaiting = false
    ..authKey = '';
}

class LogInConnector extends ConnOp<AppState, LogInState> {
  @override
  LogInState get(AppState state) {
    return state.logInState;
  }

  @override
  void set(AppState state, LogInState subState) {
    state.logInState = subState;
    state..userName = subState.userName.text
        ..port = subState.serverPort.text
        ..ipAddr = subState.serverIP.text
        ..authKey = subState.authKey;
  }
}
