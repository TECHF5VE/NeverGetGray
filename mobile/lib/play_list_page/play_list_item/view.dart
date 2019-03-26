import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Widget buildView(
    PlayListItemState state, Dispatch dispatch, ViewService viewService) {
  return ListTile(
    contentPadding: EdgeInsets.only(top: 24, left: 32, right: 16, bottom: 24),
    onTap: () {},
    leading: Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(state.album),
          )),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(state.name),
        Text('0 songs'),
      ],
    ),
    trailing: Icon(
      Icons.chevron_right,
      size: 64,
      color: Colors.grey,
    ),
  );
}
