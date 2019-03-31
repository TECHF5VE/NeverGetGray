import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'action.dart';

Widget buildView(
    PlayListItemState state, Dispatch dispatch, ViewService viewService) {
  return ListTile(
    contentPadding: EdgeInsets.only(top: 16, left: 32, right: 16, bottom: 24),
    onTap: () => dispatch(PlayListItemActionCreator.onNavigateToSongsListAction(state)),
    leading: Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(state.songs.isEmpty
                ? 'https://i.imgur.com/zJCOw.jpg'
                : state.songs[0].albumImg),
          )),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(state.name),
        Text('${state.songs.length} songs'),
      ],
    ),
    trailing: Icon(
      Icons.chevron_right,
      size: 36,
      color: Colors.grey,
    ),
  );
}
