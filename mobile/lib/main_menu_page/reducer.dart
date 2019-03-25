import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PageState> buildReducer() {
  return asReducer(
    <Object, Reducer<PageState>> {
      PageAction.initPage : _initPageReducer,
      PageAction.onTabChangeAction:_changeTagReducer,
    }
  );
}

PageState _initPageReducer(PageState state, Action action) {
  final newState = PageState()
  ..currentTagType = TagType.MusicPlayer;
  return newState;
}

PageState _changeTagReducer(PageState state, Action action) {
  final newState = state.clone();
  newState.currentTagType = action.payload;
  return newState;
}
