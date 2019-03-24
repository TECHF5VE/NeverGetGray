import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import '../music_player_page/cover_component/action.dart';

final _appBar = <TagType, PreferredSizeWidget>{
  TagType.MusicPlayer: null,
  TagType.PlayList: AppBar(title: Text('Play List')),
  TagType.Settings: AppBar(title: Text('Settings')),
};

Widget buildView(
    PageState pageState, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: _appBar[pageState.currentTagType],
    body: Container(
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
                  padding: const EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0, bottom: 10.0),
                  child: viewService.buildComponent('cover'),
                ),

                Column(children: <Widget>[
                  Text("Album Name"),
                  Text("Artist Name"),
                ],),
                
                Container(
                  padding: const EdgeInsets.only(top: 32.0, left: 0.0, right: 0.0, bottom: 32.0),
                  child: viewService.buildComponent('play_controller'),
                )
              ])),
        ],
      ),
    ),
    bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            title: Text('Music'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Play List'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          )
        ],
        fixedColor: Colors.blue,
        currentIndex: pageState.currentTagType.index,
        onTap: (index) {
          // dispatch(PageActionCreator.onTabChangeAction(TagType.values[index]));
          dispatch(CoverActionCreator.onPlayOrPauseAction(true));
        }),
    floatingActionButton: null,
  );
}
