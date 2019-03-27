import 'package:fish_redux/fish_redux.dart';

enum RegisterAction {
  onRegister,
  inputRefresh,

  registerPending,
  registerError,
  registerSuccess,
}

class RegisterActionCreator {
  static Action onRegisterAction(
          {String userName,
          String password,
          String ipAddr,
          String port,
          String privateKey}) =>
      Action(RegisterAction.onRegister, payload: <String, String>{
        'userName': userName,
        'password': password,
        'ipAddr': ipAddr,
        'port': port,
        'privateKey': privateKey,
      });

  static Action inputRefreshAction() => Action(RegisterAction.inputRefresh);

  static Action registerPendingAction() =>
      Action(RegisterAction.registerPending);
  static Action registerErrorAction() => Action(RegisterAction.registerError);
  static Action registerSuccesAction() =>
      Action(RegisterAction.registerSuccess);
}
