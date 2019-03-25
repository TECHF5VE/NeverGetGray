import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Widget buildView(
    PlayListItemState state, Dispatch dispatch, ViewService viewService) {
  return ListTile(
    contentPadding: EdgeInsets.only(top: 24, left: 32, right: 16, bottom: 16),
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

  // Container(
  //     padding: EdgeInsets.only(left: 0, right: 12, top: 32),
  //     child:
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: <Widget>[
  //         Container(
  //           width: 72,
  //           height: 72,
  //           decoration: BoxDecoration(
  //               shape: BoxShape.rectangle,
  //               image: DecorationImage(
  //                 fit: BoxFit.cover,
  //                 image: NetworkImage(state.album),
  //               )),
  //         ),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Text(state.name),
  //             Text('0 songs'),
  //           ],
  //         ),
  //         Icon(
  //           Icons.chevron_right,
  //           size: 64,
  //           color: Colors.grey,
  //         ),
  //       ],
  //     ));
}
