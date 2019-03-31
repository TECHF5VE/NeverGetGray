import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Widget buildView(
    SongsListItemState state, Dispatch dispatch, ViewService viewService) {
  return ListTile(
    leading: Text('${state.index}', style: TextStyle(fontSize: 18)),
    title: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(state.name, style: TextStyle(fontWeight: FontWeight.bold),),
        Text('${state.artist} - ${state.album}')
      ],
    ),
    trailing: Stack(
      alignment: AlignmentDirectional.centerEnd,
      fit: StackFit.passthrough,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              print('star');
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            print('menu');
          },
        ),
      ],
    ),
    onTap: () {},
  );
}
