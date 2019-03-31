import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';

import '../play_list_page/play_list_item/state.dart';

Widget buildView(
    PlayListItemState state, Dispatch dispatch, ViewService viewService) {
  final adapter = viewService.buildAdapter();
  return Scaffold(
    appBar: AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        'Songs',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      elevation: 0,
    ),
    body: Column(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(state.songs.isEmpty
                              ? ''
                              : state.songs[0].albumImg),
                        ))),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          state.name,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text('Songs : ${state.songs.length}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          child: Expanded(
              child: Container(
            padding: EdgeInsets.only(top: 0),
            child: ListView.separated(
              separatorBuilder: (ctx, index) => Divider(
                    height: 1,
                    color: Colors.grey,
                    indent: 24,
                  ),
              itemBuilder: adapter.itemBuilder,
              itemCount: adapter.itemCount,
            ),
          )),
        ),
        Container(
          child: viewService.buildComponent('play_controller'),
          padding: EdgeInsets.only(bottom: 10),
        ),
      ],
    ),
  );
}
