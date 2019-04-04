import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'action.dart';
import 'state.dart';

import 'package:never_get_gray_mobile/main_menu_page/page.dart' as mainPage;
import 'package:never_get_gray_mobile/register_page/page.dart' as registerPage;

import 'package:never_get_gray_mobile/unit/network.dart';

import '../unit/global_store.dart';

Effect<LogInState> buildEffect() {
  return combineEffects(<Object, Effect<LogInState>>{
    Lifecycle.initState: _init,
    LogInAction.onLogIn: _onLogIn,
    LogInAction.onRegister: _onRegister,
  });
}

void _init(Action action, Context<LogInState> ctx) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final userName = preferences.getString('userName');
  if (userName != null) {
    final password = preferences.getString('password');
    final ipAddr = preferences.getString('ipAddr');
    final port = preferences.getString('port');

    ctx.dispatch(LogInActionCreator.initFromStorageAction({
      'userName': userName,
      'password': password,
      'ipAddr': ipAddr,
      'port': port,
    }));

    ctx.dispatch(LogInActionCreator.onLogInAction(
        userName: userName, password: password, ipAddr: ipAddr, port: port));
  }
}

void _onLogIn(Action action, Context<LogInState> ctx) async {
  final logInInfo = action.payload as Map<String, String>;

  ctx.dispatch(LogInActionCreator.logInPendingAction());

  try {
    final response = await NetWorkUnit.post(
        logInInfo['ipAddr'], 'session', logInInfo['port'], null, {
      'username': logInInfo['userName'],
      'password': logInInfo['password'],
    });

    if (response.data['code'] == '200') {
      ctx.dispatch(LogInActionCreator.logInSuccessAcion());

      GlobalStoreUtil.globalState
          .dispatch(AppStateActionCreator.updateGlobalInfoAction({
        'userName': ctx.state.userName.text,
        'ipAddr': ctx.state.serverIP.text,
        'port': ctx.state.serverPort.text,
        'authKey': response.data['data']['auth_key'],
      }));

      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('userName', logInInfo['userName']);
      await preferences.setString('password', logInInfo['password']);
      await preferences.setString('ipAddr', logInInfo['ipAddr']);
      await preferences.setString('port', logInInfo['port']);

      Navigator.of(ctx.context)
          .pushReplacement(MaterialPageRoute<Map<String, String>>(
        builder: (buildCtx) => mainPage.MainMenuPage().buildPage(null),
      ));
    } else {
      _showFailedDialog('Invalid user name or password.', ctx);
    }
  } catch (e) {
    // print(e);
    _showFailedDialog('Invalid private server IP address or port number.', ctx);
  }
}

void _showFailedDialog(String message, Context<LogInState> ctx) {
  showDialog(
      context: ctx.context,
      builder: (context) => AlertDialog(
            title: Text('Log In Failed'),
            content: Text(
              message,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          )).then((value) {
    ctx.dispatch(LogInActionCreator.logInErrorAction());
  });
}

void _onRegister(Action action, Context<LogInState> ctx) {
  Navigator.of(ctx.context).push(MaterialPageRoute(
      builder: (buildCtx) => registerPage.RegisterPage().buildPage(null)));
}
