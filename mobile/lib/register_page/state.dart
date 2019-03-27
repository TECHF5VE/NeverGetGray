import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';

class RegisterState implements Cloneable<RegisterState> {
  TextEditingController userName;
  TextEditingController password;
  TextEditingController serverIP;
  TextEditingController serverPort;
  TextEditingController privateKey;

  bool isWaiting;

  @override
  RegisterState clone() {
    var newState = RegisterState()
      ..userName = this.userName
      ..password = this.password
      ..serverIP = this.serverIP
      ..serverPort = this.serverPort
      ..privateKey = this.privateKey
      ..isWaiting = this.isWaiting;

    return newState;
  }
}

RegisterState initState(Map<String, dynamic> args) {
  return RegisterState()
    ..userName = (TextEditingController()..text = '')
    ..password = (TextEditingController()..text = '')
    // ..serverIP = (TextEditingController()..text = 'https://www.easy-mock.com/mock/5c9b493193944f200184f1d0/api')
    ..serverIP = (TextEditingController()..text = '')
    ..serverPort = (TextEditingController()..text = '')
    ..privateKey = (TextEditingController()..text = '')
    ..isWaiting = false;
}
