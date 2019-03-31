import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Widget buildView(
    PlayListState state, Dispatch dispatch, ViewService viewService) {
  final adapter = viewService.buildAdapter();
  return new DefaultTabController(
      length: 4,
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
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
          body: _buildBody(adapter, viewService)));
}

Widget _buildBody(ListAdapter adapter, ViewService viewService) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
            iconSize: 32,
          ),
          Padding(
            child: IconButton(
                icon: Icon(Icons.filter_list), onPressed: () {}, iconSize: 32),
            padding: EdgeInsets.only(right: 16),
          ),
        ],
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
        padding: EdgeInsets.only(bottom: 18.5),
      ),
    ],
  );
}
