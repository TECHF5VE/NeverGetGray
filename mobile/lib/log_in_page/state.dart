import 'package:fish_redux/fish_redux.dart';

class LogInState implements Cloneable<LogInState> {
  String userName;
  String password;
  String serverIP;
  String serverPort;

  @override
  LogInState clone() {
    var newState = LogInState()
    ..userName = this.userName
    ..password = this.password
    ..serverIP = this.serverIP
    ..serverPort = this.serverPort;
    return newState;
  }
}

LogInState initState(Map<String, dynamic> args) {
  return LogInState()
  ..userName = ''
  ..password = ''
  ..serverIP = ''
  ..serverIP = '';
}
