import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'action.dart';

Widget buildView(
    RegisterState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    resizeToAvoidBottomPadding: true,
    appBar: AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        'Register',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      elevation: 0,
    ),
    body: _buildBody(state, dispatch, viewService),
  );
}

Widget _buildBody(
    RegisterState state, Dispatch dispatch, ViewService viewService) {
  final widgets = <Widget>[
    Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            child: _buildFileds(
                'Input user name',
                Icons.portrait,
                false,
                state.userName,
                () => dispatch(RegisterActionCreator.inputRefreshAction())),
            padding: EdgeInsets.only(top: 36),
          ),
          _buildFileds('Input password', Icons.lock_open, true, state.password,
              () => dispatch(RegisterActionCreator.inputRefreshAction())),
          _buildFileds(
              'Input private server\'s IP address / domain name',
              Icons.network_check,
              false,
              state.serverIP,
              () => dispatch(RegisterActionCreator.inputRefreshAction())),
          _buildFileds(
              'Input private server\'s port number',
              Icons.confirmation_number,
              false,
              state.serverPort,
              () => dispatch(RegisterActionCreator.inputRefreshAction()),
              numberOnly: true),
          _buildFileds(
            'Input private server\'s key',
            Icons.vpn_key,
            false,
            state.privateKey,
            () => dispatch(RegisterActionCreator.inputRefreshAction()),
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
                    'Register',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                onPressed: _buttonEnable(state)
                    ? () => dispatch(RegisterActionCreator.onRegisterAction(
                          userName: state.userName.text,
                          password: state.password.text,
                          ipAddr: state.serverIP.text,
                          port: state.serverPort.text,
                          privateKey: state.privateKey.text,
                        ))
                    : null,
              ),
            ),
          ),
        ])
  ];

  if (state.isWaiting) {
    widgets.add(_buildCircularProgressIndicator());
  }

  return LayoutBuilder(
    builder: (ctx, constraints) {
      return SingleChildScrollView(
          child: ConstrainedBox(
        child: Stack(children: widgets),
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
                'Register ...',
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

bool _buttonEnable(RegisterState state) {
  return _textFieldValidate(state.userName.text) &&
      _textFieldValidate(state.password.text) &&
      _textFieldValidate(state.serverIP.text) &&
      _textFieldValidate(state.serverPort.text) &&
      _textFieldValidate(state.privateKey.text);
}
