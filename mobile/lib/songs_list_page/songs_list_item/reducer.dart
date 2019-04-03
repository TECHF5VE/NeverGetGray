import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SongsListItemState> buildReducer() {
  return asReducer(<Object, Reducer<SongsListItemState>>{
    SongsListItemAction.updateAlbumImg: _updateAlbumImgReducer,
    SongsListItemAction.updateLyrics: _updateLyrics,
    SongsListItemAction.updateIsPlaying: _updateIsPlaying,
  });
}

SongsListItemState _updateAlbumImgReducer(
    SongsListItemState state, Action action) {
  if (state.index == action.payload['index'] as int) {
    final newState = state.clone();
    return newState..albumImg = action.payload['albumImg'];
  } else {
    return state;
  }
}

SongsListItemState _updateLyrics(SongsListItemState state, Action action) {
  if (state.index == action.payload['index'] as int) {
    final newState = state.clone();
    return newState..lyrics = action.payload['lyrics'];
  } else {
    return state;
  }
}

SongsListItemState _updateIsPlaying(SongsListItemState state, Action action) {
  if (state.index == action.payload['index'] as int) {
    final newState = state.clone();
    return newState..isPlaying = action.payload['isPlaying'];
  } else {
    return state;
  }

}
