import 'package:fish_redux/fish_redux.dart';

enum LogInAction {
  onLogIn,

  logInPending,
  logInSuccess,
  logInError,

  updateLogInInfo,
  updateAuthKey,
  initFromStorage,

  onRegister,
}

class LogInActionCreator {
  static Action onLogInAction(
          {String userName, String password, String ipAddr, String port}) =>
      Action(LogInAction.onLogIn, payload: <String, String>{
        'userName': userName,
        'password': password,
        'ipAddr': ipAddr,
        'port': port,
      });

  static Action logInPendingAction() => Action(LogInAction.logInPending);
  static Action logInErrorAction() => Action(LogInAction.logInError);
  static Action logInSuccessAcion() => Action(LogInAction.logInSuccess);

  static Action updateLogInInfoAction() => Action(LogInAction.updateLogInInfo);

  static Action initFromStorageAction(Map<String, String> data) => Action(LogInAction.initFromStorage, payload: data);

  static Action onRegisterAction() => Action(LogInAction.onRegister);

  static Action updateAuthKey(String authKey) => Action(LogInAction.updateAuthKey, payload: authKey);
}
