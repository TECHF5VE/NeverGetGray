import 'package:fish_redux/fish_redux.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'action.dart';
import 'state.dart';

import 'package:never_get_gray_mobile/main_menu_page/page.dart' as mainPage;

Effect<LogInState> buildEffect() {
  return combineEffects(<Object, Effect<LogInState>>{
    Lifecycle.initState: _init,
    LogInAction.onLogIn: _onLogIn,
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
  // final apiPath = logInInfo['ipAddr'] + 'session:' + logInInfo['port'];
  final apiPath = logInInfo['ipAddr'] + 'session1';

  ctx.dispatch(LogInActionCreator.logInPendingAction());

  new Future.delayed(const Duration(microseconds: 2000000), () async {
    try {
      final response = await Dio().post(apiPath, data: {
        'username': logInInfo['userName'],
        'password': logInInfo['password'],
      });
      if (response.data['code'] == '200') {
        ctx.dispatch(LogInActionCreator.logInSuccessAcion());

        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString('userName', logInInfo['userName']);
        await preferences.setString('password', logInInfo['password']);
        await preferences.setString('ipAddr', logInInfo['ipAddr']);
        await preferences.setString('port', logInInfo['port']);

        Navigator.of(ctx.context)
            .push<Map<String, String>>(MaterialPageRoute<Map<String, String>>(
          builder: (BuildContext buildCtx) =>
              mainPage.MainMenuPage().buildPage({
                'userName': ctx.state.userName.text,
                'password': ctx.state.password.text,
                'ipAddr': ctx.state.serverIP.text,
                'port': ctx.state.serverPort.text,
                'auth_key': response.data['data']['auth_key'],
              }),
        ));
      } else {
        showDialog(
            context: ctx.context,
            builder: (context) => AlertDialog(
                  title: Text('Log In Failed'),
                  content: Text(
                    'Invalid user name or password.',
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
    } catch (e) {
      // print(e);
      showDialog(
          context: ctx.context,
          builder: (context) => AlertDialog(
                title: Text('Log In Failed'),
                content: Text(
                  'Invalid private server IP address or port number.',
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
  });
}
