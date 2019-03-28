import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PageState> buildReducer() {
  return asReducer(<Object, Reducer<PageState>>{
    PageAction.initPage: _initPageReducer,
    PageAction.onTabChangeAction: _changeTagReducer,
    PageAction.initError: _initErrorReducer,
    PageAction.initPending: _initPendingReducer,
    PageAction.initSuccess: _initSuccessReducer,
    PageAction.updatePlayList: _updatePlayListReducer,
  });
}

PageState _initPageReducer(PageState state, Action action) {
  final newState = PageState()..currentTagType = TagType.MusicPlayer;
  return newState;
}

PageState _changeTagReducer(PageState state, Action action) {
  final newState = state.clone();
  newState.currentTagType = action.payload;
  return newState;
}

PageState _initErrorReducer(PageState state, Action action) {
  final newState = state.clone();
  newState.isWaiting = false;
  return newState;
}

PageState _initSuccessReducer(PageState state, Action action) {
  final newState = state.clone();
  newState.isWaiting = false;
  return newState;
}

PageState _initPendingReducer(PageState state, Action action) {
  final newState = state.clone();
  newState.isWaiting = true;
  return newState;
}

PageState _updatePlayListReducer(PageState state, Action action) {
  final newState = state.clone();
  newState.playListItems = action.payload;
  return newState;
}
