import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:never_get_gray_mobile/unit/global_store.dart';
import '../play_list_page/state.dart';
import '../play_list_page/play_list_item/state.dart';
import '../setting_page/state.dart';
import '../music_player_page/state.dart';

enum TagType {
  MusicPlayer,
  PlayList,
  Settings,
}

class PageState extends AppSubState implements Cloneable<PageState> {
  TagType currentTagType;
  String coverUri;
  num imageAngle;
  Timer timer;
  List<PlayListItemState> playListItems;
  TabController tabController;

  bool isWaiting;

  PageState(AppState state) : super(state);

  @override
  PageState clone() {
    var newState = PageState(this.appState)
      ..currentTagType = this.currentTagType
      ..imageAngle = this.imageAngle
      ..coverUri = this.coverUri
      ..timer = this.timer
      ..playListItems = this.playListItems
      ..isWaiting = this.isWaiting
      ..tabController = this.tabController;

    return newState;
  }
}

PageState initState(Map<String, String> args) {
  return PageState(null)
    ..currentTagType = TagType.MusicPlayer
    ..coverUri = 'https://i.imgur.com/jg6lMnv.png'
    ..timer = null
    ..imageAngle = 0.0
    ..playListItems = []
    ..isWaiting = false
    ..appState = null;
}

class MainMenuConnector extends ConnOp<AppState, PageState> {
  @override
  PageState get(AppState state) => state.pageState..appState = state;

  @override
  void set(AppState state, PageState subState) {
    state.pageState = subState;
  }
}

class PlayListConnector extends ConnOp<PageState, PlayListState> {
  @override
  PlayListState get(PageState state) {
    final playListState = PlayListState(state.appState)
      ..playListItems = state.playListItems;

    return playListState;
  }

  @override
  void set(PageState state, PlayListState substate) {}
}

class SettingConnector extends ConnOp<PageState, SettingState> {
  @override
  SettingState get(PageState state) {
    return SettingState(state.appState);
  }

  @override
  void set(PageState state, SettingState substate) {}
}

class MusicPlayerConnector extends ConnOp<PageState, MusicPlayerState> {
  @override
  MusicPlayerState get(PageState state) {
    return MusicPlayerState(state.appState)
      ..imageAngle = state.imageAngle
      ..coverUri = state.coverUri
      ..timer = state.timer;
  }

  @override
  void set(PageState state, MusicPlayerState substate) {
    // state.appState = substate.appState;
  }
}
