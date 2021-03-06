import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(LogInState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: null,
    body: _buildBody(state, dispatch, viewService),
    resizeToAvoidBottomPadding: true,
  );
}

Widget _buildBody(
    LogInState state, Dispatch dispatch, ViewService viewService) {
  final widgetList = <Widget>[
    Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 100, left: 30, right: 30, bottom: 60),
            child: Text(
              'Never Get Grey',
              style: TextStyle(fontSize: 38, color: Colors.blue),
            ),
          ),
          _buildFileds('Input user name', Icons.portrait, false, state.userName,
              () => dispatch(LogInActionCreator.updateLogInInfoAction())),
          _buildFileds('Input password', Icons.lock_open, true, state.password,
              () => dispatch(LogInActionCreator.updateLogInInfoAction())),
          _buildFileds(
              'Input private server\'s IP address / domain name',
              Icons.network_check,
              false,
              state.serverIP,
              () => dispatch(LogInActionCreator.updateLogInInfoAction())),
          _buildFileds(
              'Input private server\'s port number',
              Icons.confirmation_number,
              false,
              state.serverPort,
              () => dispatch(LogInActionCreator.updateLogInInfoAction()),
              numberOnly: true),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                child: InkWell(
                  child: Text('register',
                      style: TextStyle(color: Colors.blue, fontSize: 16)),
                  onTap: () => dispatch(LogInActionCreator.onRegisterAction()),
                ),
                padding: EdgeInsets.only(right: 32),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 40),
            width: 340.0,
            child: Card(
              color: Colors.white,
              elevation: 4.0,
              child: FlatButton(
                textColor: Colors.blue,
                disabledTextColor: Colors.grey,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Log In',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                onPressed: _buttonEnable(state)
                    ? () => dispatch(LogInActionCreator.onLogInAction(
                        userName: state.userName.text,
                        password: state.password.text,
                        ipAddr: state.serverIP.text,
                        port: state.serverPort.text))
                    : null,
              ),
            ),
          ),
        ]),
  ];

  if (state.isWaiting) {
    widgetList.add(_buildCircularProgressIndicator());
  }

  return LayoutBuilder(
    builder: (ctx, constraints) {
      return SingleChildScrollView(
          child: ConstrainedBox(
        child: Stack(children: widgetList),
        constraints: !state.isWaiting
            ? BoxConstraints(minHeight: constraints.maxHeight)
            : BoxConstraints(maxHeight: constraints.maxHeight),
      ));
    },
  );
}

Widget _buildCircularProgressIndicator() {
  return Stack(
    children: [
      Opacity(
        opacity: 0.3,
        child: const ModalBarrier(dismissible: false, color: Colors.grey),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(
              child: Text(
                'Log In ...',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              padding: EdgeInsets.only(top: 32),
            ),
          ],
        ),
      ),
    ],
  );
}

typedef void TextChangedCallBack();

Widget _buildFileds(String hintText, IconData icon, bool isPassword,
    TextEditingController controller, TextChangedCallBack callback,
    {bool numberOnly = false}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(25.0, 0.0, 30.0, 20.0),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
          child: Icon(
            icon,
            size: 32,
          )),
      Expanded(
          child: TextField(
        controller: controller,
        onChanged: (txt) => callback(),
        keyboardType: numberOnly ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          errorText:
              !_textFieldValidate(controller.text) ? 'Invalid input' : null,
        ),
        obscureText: isPassword,
      ))
    ]),
  );
}

bool _textFieldValidate(String text) {
  return text != null && text.isNotEmpty;
}

bool _buttonEnable(LogInState state) {
  return _textFieldValidate(state.userName.text) &&
      _textFieldValidate(state.password.text) &&
      _textFieldValidate(state.serverIP.text) &&
      _textFieldValidate(state.serverPort.text);
}
