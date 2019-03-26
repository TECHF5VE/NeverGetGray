import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

const _iconSize = 40.0;

Widget buildView(
    SettingState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    padding: EdgeInsets.only(top: 16),
    child: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Ink(
            color: Colors.white,
            child: ListTile(
              leading: Icon(
                Icons.account_circle,
                size: _iconSize,
              ),
              title: Text('Account'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                print('taped');
              },
            ),
          ),
        ),
        Container(
          // color: Colors.white,
          margin: EdgeInsets.only(bottom: 5),
          child: Ink(
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.settings_remote, size: _iconSize),
              title: Text('Server'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Ink(
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.clear, size: _iconSize),
              title: Text('Clear Cache'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
        ),
        Container(
          child: Ink(
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.more, size: _iconSize),
              title: Text('About'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
        ),
      ],
    ),
  );
}
