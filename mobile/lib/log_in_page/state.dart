import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';

class LogInState implements Cloneable<LogInState> {
  TextEditingController userName;
  TextEditingController password;
  TextEditingController serverIP;
  TextEditingController serverPort;

  bool isWaiting;

  @override
  LogInState clone() {
    var newState = LogInState()
      ..userName = this.userName
      ..password = this.password
      ..serverIP = this.serverIP
      ..serverPort = this.serverPort
      ..isWaiting = this.isWaiting;
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
      ..text = '')
    ..serverPort = (TextEditingController()
      ..text = '')
    ..isWaiting = false;
}
