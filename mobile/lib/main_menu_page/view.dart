import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(
    PageState pageState, Dispatch dispatch, ViewService viewService) {
  return DefaultTabController(
    length: 3,
    child: Scaffold(
      resizeToAvoidBottomPadding: false,
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
            child: viewService.buildComponent('music_player'),
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
