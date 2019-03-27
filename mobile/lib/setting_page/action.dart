import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

enum SettingAction {
  onLogIn,
  logIn,
}

class SettingActionCreator {
  Action onLogInAction(
          String userName, String password, String ipAddr, String port) =>
      Action(SettingAction.onLogIn,
          payload: <String, String>{
            'userName': userName,
            'password': password,
            'ipAddr': ipAddr,
            'port': port,
          });

    Action logInAction() => Action(SettingAction.logIn);
}
