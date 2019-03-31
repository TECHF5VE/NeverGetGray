import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

enum SongsListItemAction {
  onPlaySong,
  updateAlbumImg,
  updateLyrics,
}

class SongsListItemActionCreator {
  static Action onPlaySongAction(int index) =>
      Action(SongsListItemAction.onPlaySong, payload: index);

  static Action udpateAlbumImg(String albumImg) =>
      Action(SongsListItemAction.updateAlbumImg, payload: albumImg);

  static Action udpateLyrics(String lyrics) =>
      Action(SongsListItemAction.updateLyrics, payload: lyrics);
}
