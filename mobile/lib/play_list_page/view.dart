import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Widget buildView(
    PlayListState state, Dispatch dispatch, ViewService viewService) {
      final adapter = viewService.buildAdapter();
  return new DefaultTabController(
      length: 3,
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
          children: <Widget>[
            Container(
              child: Expanded(
                child: ListView.builder(
                  itemBuilder: adapter.itemBuilder,
                  itemCount:  adapter.itemCount,
                ),
              ),
            ),
            Container(
              child: viewService.buildComponent('play_controller'),
              padding: EdgeInsets.only(bottom: 18.5),
            ),
          ],
        ),
      ));
}
