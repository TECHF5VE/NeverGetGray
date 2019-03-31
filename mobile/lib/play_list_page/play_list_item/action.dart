import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

enum PlayListItemAction {
  onNavigateToSongsList,
}

class PlayListItemActionCreator {
  static Action onNavigateToSongsListAction(PlayListItemState state) =>
      Action(PlayListItemAction.onNavigateToSongsList, payload: state);
}
