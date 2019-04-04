import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Widget buildView(MusicPlayerState state, Dispatch dispatch, ViewService viewService) {
  return _buildPlayMenu(viewService);
}


Widget _buildPlayMenu(ViewService viewService) {
  return Container(
    padding: const EdgeInsets.only(top: 32.0),
    child: Row(
      children: <Widget>[
        Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 24.0, top: 20.0),
                child: Text(
                  'Music Name',
                  style: TextStyle(fontSize: 32),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 0.0, right: 0.0, bottom: 36.0),
                child: viewService.buildComponent('cover'),
              ),
              Column(
                children: <Widget>[
                  Text("Album Name"),
                  Text("Artist Name"),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 32.0, left: 0.0, right: 0.0, bottom: 0.0),
                child: viewService.buildComponent('play_controller'),
              )
            ])),
      ],
    ),
  );
}
