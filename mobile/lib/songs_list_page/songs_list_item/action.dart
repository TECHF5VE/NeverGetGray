import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

enum SongsListItemAction {
  onPlaySong,
  updateAlbumImg,
  updateLyrics,
  updateIsPlaying,
}

class SongsListItemActionCreator {
  static Action onPlaySongAction(int index) =>
      Action(SongsListItemAction.onPlaySong, payload: index);

  static Action updateAlbumImgAction(String albumImg, int index) =>
      Action(SongsListItemAction.updateAlbumImg,
          payload: {'albumImg': albumImg, 'index': index});

  static Action updateLyricsAction(String lyrics, int index) =>
      Action(SongsListItemAction.updateLyrics,
          payload: {'lyrics': lyrics, 'index': index});

  static Action updateIsPlayingAction(bool isPlaying, int index) =>
      Action(SongsListItemAction.updateIsPlaying,
          payload: {'isPlaying': isPlaying, 'index': index});
}
