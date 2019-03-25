import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import '../music_player_page/cover_component/state.dart';
import '../music_player_page/play_controller_component/state.dart';
import '../play_list_page/state.dart';
import '../play_list_page/play_list_item/state.dart';

enum TagType {
  MusicPlayer,
  PlayList,
  Settings,
}

class PageState implements Cloneable<PageState> {
  TagType currentTagType;
  String coverUri;
  num imageAngle;
  Timer timer;
  List<PlayListItemState> playListItems;

  @override
  PageState clone() {
    var newState = PageState()
    ..currentTagType = this.currentTagType
    ..coverUri = this.coverUri
    ..imageAngle = this.imageAngle
    ..timer = this.timer
    ..playListItems = playListItems;

    return newState;
  }
}

PageState initState(Map<String, dynamic> args) {
  return PageState()
  ..currentTagType = TagType.MusicPlayer
  ..coverUri = 'https://i.imgur.com/jg6lMnv.png'
  ..timer = null
  ..imageAngle = 0.0
  ..playListItems = [];
}

class CoverConnector extends ConnOp<PageState, CoverState> {
  @override
  CoverState get(PageState state) {
    final coverState = CoverState()
    ..coverUrl = state.coverUri
    ..imageAngle = state.imageAngle
    ..timer = state.timer;
    return coverState;
  }

  @override
  void set(PageState state, CoverState substate) {
    state.coverUri = substate.coverUrl;
    state.imageAngle = substate.imageAngle;
    state.timer = substate.timer;
  }
}

class PlayControllerConnector extends ConnOp<PageState, PlayControllerState> {
  @override
  PlayControllerState get(PageState state) {
    return PlayControllerState();
  }

  @override
  void set(PageState state, PlayControllerState substate) {}
}

class PlayListConnector extends ConnOp<PageState, PlayListState> {
  @override
  PlayListState get(PageState state) {
    final playListState = PlayListState()
      ..playListItems = state.playListItems;

    return playListState;
  }

  @override
  void set(PageState state, PlayListState substate) {}
}
