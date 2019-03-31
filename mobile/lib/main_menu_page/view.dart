import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

final _appBar = <TagType, PreferredSizeWidget>{
  TagType.MusicPlayer: null,
  TagType.PlayList: AppBar(
    title: Text(
      'Play List',
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Color.fromARGB(255, 246, 246, 246),
    elevation: 0,
  ),
  TagType.Settings: AppBar(
    title: Text(
      'Settings',
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Color.fromARGB(255, 246, 246, 246),
    elevation: 0,
  ),
};

Widget buildView(
    PageState pageState, Dispatch dispatch, ViewService viewService) {
  return DefaultTabController(
    length: 3,
    child: Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: _appBar[pageState.currentTagType],
      body: TabBarView(
        children: <Widget>[
          _buildBodyStack(
              pageState, dispatch, viewService, TagType.MusicPlayer),
          _buildBodyStack(pageState, dispatch, viewService, TagType.PlayList),
          _buildBodyStack(pageState, dispatch, viewService, TagType.Settings),
        ],
        controller: pageState.tabController,
      ),
      bottomNavigationBar: TabBar(
        tabs: <Widget>[
          Tab(
            icon: Icon(
              Icons.music_note,
              color: pageState.tabController.index == 0 ? Colors.blue : Colors.grey,
            ),
            child: Text('Music', style: TextStyle(color: pageState.tabController.index == 0 ? Colors.blue : Colors.grey)),
          ),
          Tab(
            icon: Icon(
              Icons.list,
              color: pageState.tabController.index == 1 ? Colors.blue : Colors.grey,
            ),
            child: Text('Play List', style: TextStyle(color: pageState.tabController.index == 1 ? Colors.blue : Colors.grey)),
          ),
          Tab(
            icon: Icon(
              Icons.settings,
              color: pageState.tabController.index == 2 ? Colors.blue : Colors.grey,
            ),
            child: Text('Settings', style: TextStyle(color: pageState.tabController.index == 2 ? Colors.blue : Colors.grey)),
          )
        ],
        controller: pageState.tabController,
      ),
      floatingActionButton: null,
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
    ),
  );
}

Widget _buildBodyStack(PageState pageState, Dispatch dispatch,
    ViewService viewService, TagType type) {
  final widgets = <Widget>[
    _buildBody(type, viewService),
  ];

  if (pageState.isWaiting) {
    widgets.add(_buildCircularProgressIndicator('Fetch play lists ...'));
  }

  return Stack(
    children: widgets,
  );
}

Widget _buildBody(TagType type, ViewService viewService) {
  switch (type) {
    case TagType.MusicPlayer:
      return LayoutBuilder(
        builder: (ctx, constraints) {
          return SingleChildScrollView(
              child: ConstrainedBox(
            child: _buildPlayMenu(viewService),
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
          ));
        },
      );
    case TagType.PlayList:
      return _buildPlayList(viewService);
    case TagType.Settings:
      return _buildSetting(viewService);
    default:
      return null;
  }
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

Widget _buildPlayList(ViewService viewService) {
  return viewService.buildComponent('play_list');
}

Widget _buildSetting(ViewService viewService) {
  return viewService.buildComponent('setting');
}

Widget _buildCircularProgressIndicator(String message) {
  return Stack(
    children: [
      Opacity(
        opacity: 0.3,
        child: const ModalBarrier(dismissible: false, color: Colors.grey),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(
              child: Text(
                message,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              padding: EdgeInsets.only(top: 32),
            ),
          ],
        ),
      ),
    ],
  );
}
