import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SongsListItemState> buildReducer() {
  return asReducer(<Object, Reducer<SongsListItemState>>{
    SongsListItemAction.updateAlbumImg: _updateAlbumImgReducer,
    SongsListItemAction.updateLyrics: _updateLyrics,
  });
}

SongsListItemState _updateAlbumImgReducer(
    SongsListItemState state, Action action) {
  final newState = state.clone();
  return newState..albumImg = action.payload;
}


SongsListItemState _updateLyrics(
    SongsListItemState state, Action action) {
  final newState = state.clone();
  return newState..lyrics = action.payload;
}
