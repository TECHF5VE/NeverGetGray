import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Widget buildView(LogInState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      appBar: null,
      body: _buildBody(state, dispatch, viewService),
      resizeToAvoidBottomPadding: false);
}

Widget _buildBody(
    LogInState state, Dispatch dispatch, ViewService viewService) {
  return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 100, left: 30, right: 30, bottom: 60),
          child: Text(
            'Never Get Grey',
            style: TextStyle(fontSize: 38),
          ),
        ),
        _buildFileds('Input user name', Icons.portrait, false),
        _buildFileds('Input password', Icons.lock_open, true),
        _buildFileds('Input private server\'s IP address / domain name', Icons.network_check, false),
        _buildFileds('Input private server\'s port number', Icons.confirmation_number, false),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              child: InkWell(
                child: Text('register',
                    style: TextStyle(color: Colors.blue, fontSize: 16)),
                onTap: () {
                  print('taped.');
                },
              ),
              padding: EdgeInsets.only(right: 32),
            ),
          ],
        ),
        new Container(
          padding: EdgeInsets.only(top: 40),
          width: 340.0,
          child: new Card(
            color: Colors.white,
            elevation: 4.0,
            child: FlatButton(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Log In',
                  style: new TextStyle(color: Colors.blue, fontSize: 16.0),
                ),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ]);
}

Widget _buildFileds(String hintText, IconData icon, bool isPassword) {
  return Padding(
    padding: EdgeInsets.fromLTRB(25.0, 0.0, 30.0, 20.0),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
          child: Icon(icon, size: 32,)),
      Expanded(
          child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
        ),
        obscureText: isPassword,
      ))
    ]),
  );
}
