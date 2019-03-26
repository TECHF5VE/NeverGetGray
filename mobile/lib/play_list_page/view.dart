import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Widget buildView(
    PlayListState state, Dispatch dispatch, ViewService viewService) {
  final adapter = viewService.buildAdapter();
  return new DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: TabBar(
          indicatorColor: Colors.blue,
          labelColor: Colors.black,
          tabs: <Widget>[
            Tab(text: 'Custom'),
            Tab(text: 'Server'),
            Tab(text: 'Albums'),
            Tab(text: 'Artists'),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
              IconButton(icon: Icon(Icons.add), onPressed: () {}, iconSize: 32,),
              IconButton(icon: Icon(Icons.filter_list), onPressed: () {}, padding: EdgeInsets.only(right: 32), iconSize: 32),
            ],),

            Container(
              child: Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 0),
                    child: ListView.builder(
                      itemBuilder: adapter.itemBuilder,
                      itemCount: adapter.itemCount,
                ),
              )),
            ),
            Container(
              child: viewService.buildComponent('play_controller'),
              padding: EdgeInsets.only(bottom: 18.5),
            ),
          ],
        ),
      ));
}
