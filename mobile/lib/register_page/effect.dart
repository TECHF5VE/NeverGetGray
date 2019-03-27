import 'package:fish_redux/fish_redux.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Effect<RegisterState> buildEffect() {
  return combineEffects(<Object, Effect<RegisterState>>{
    RegisterAction.onRegister: _onRegister,
  });
}

void _onRegister(Action action, Context<RegisterState> ctx) {
  final logInInfo = action.payload as Map<String, String>;
  // final apiPath = logInInfo['ipAddr'] + 'session:' + logInInfo['port'];
  final apiPath = logInInfo['ipAddr'] + '/userinfo';

  ctx.dispatch(RegisterActionCreator.registerPendingAction());

  new Future.delayed(const Duration(microseconds: 2000000), () async {
    try {
      final response = await Dio().post(apiPath, data: {
        'username': logInInfo['userName'],
        'password': logInInfo['password'],
        'private_key': logInInfo['privateKey'],
      });
      if (response.data['code'] == '200') {
        ctx.dispatch(RegisterActionCreator.registerSuccesAction());
        _showSuccessDialog('Register success.', ctx);
      } else {
        _showFailedDialog('Invalid user name/password/private key.', ctx);
      }
    } catch (e) {
      // print(e);
      _showFailedDialog(
          'Invalid private server IP address or port number.', ctx);
    }
  });
}

void _showFailedDialog(String message, Context<RegisterState> ctx) {
  showDialog(
      context: ctx.context,
      builder: (context) => AlertDialog(
            title: Text('Register Failed'),
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
    ctx.dispatch(RegisterActionCreator.registerErrorAction());
  });
}

void _showSuccessDialog(String message, Context<RegisterState> ctx) {
  showDialog(
      context: ctx.context,
      builder: (context) => AlertDialog(
            title: Text('Register Success'),
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
    ctx.dispatch(RegisterActionCreator.registerErrorAction());
    Navigator.of(ctx.context).pop();
  });
}
