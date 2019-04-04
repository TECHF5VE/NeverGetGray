import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'action.dart';

Widget buildView(
    SongsListItemState state, Dispatch dispatch, ViewService viewService) {
  return ListTile(
    leading: Text('${state.index + 1}',
        style: TextStyle(
            fontSize: 18,
            color: state.isPlaying ? Colors.blue : Colors.black,
            fontWeight: state.isPlaying ? FontWeight.bold : FontWeight.normal)),
    title: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          state.name,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: state.isPlaying ? Colors.blue : Colors.black),
        ),
        Text(
          '${state.artist} - ${state.album}',
          style: TextStyle(color: state.isPlaying ? Colors.blue : Colors.black),
        )
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
    onTap: () {
      dispatch(SongsListItemActionCreator.onPlaySongAction(state.index));
    },
  );
}
