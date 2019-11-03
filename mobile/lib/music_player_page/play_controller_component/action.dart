import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:never_get_gray_mobile/play_list_page/play_list_item/state.dart';

import 'state.dart';
import '../../unit/global_store.dart';

enum PlayControllerAction {
  onUpdatePlayStatus,
  updatePlayStatus,

  onUpdatePlayQueueMode,
  updatePlayQueueMode,

  onPlayNextSong,
  onPlayLastSong,

  updateBufferdPercentage,
  updatePlayingPosition,
  updateContentLength,

  updatePlayIndex,
  updatePlayingProgressTimer,
  updatePlayList,
}

class PlayControllerActionCreator {
  static Action onUpdatePlayStatusAction(PlayStatus status) =>
      Action(PlayControllerAction.onUpdatePlayStatus, payload: status);
  static Action updatePlayStatusAction(PlayStatus status) =>
      Action(PlayControllerAction.updatePlayStatus, payload: status);

  static Action onUpdatePlayQueueModeAction(PlayQueueMode mode) =>
      Action(PlayControllerAction.onUpdatePlayQueueMode, payload: mode);
  static Action updatePlayQueueModeAction(PlayQueueMode mode) =>
      Action(PlayControllerAction.updatePlayQueueMode, payload: mode);

  static Action onPlayNextSongAction() =>
      Action(PlayControllerAction.onPlayNextSong);

  static Action onPlayLastSongAction() =>
      Action(PlayControllerAction.onPlayLastSong);

  static Action updateBufferedPercentageAction(int percentage) =>
      Action(PlayControllerAction.updateBufferdPercentage, payload: percentage);

  static Action updatePlayingPositionAction(int position) =>
      Action(PlayControllerAction.updatePlayingPosition, payload: position);

  static Action updateContentLengthAction(int length) =>
      Action(PlayControllerAction.updateContentLength, payload: length);

  static Action updatePlayIndexAction(int index) =>
      Action(PlayControllerAction.updatePlayIndex, payload: index);

  static Action updatePlayingProgressTimerReducer(Timer timer) =>
      Action(PlayControllerAction.updatePlayingProgressTimer, payload: timer);

  static Action updatePlayListAction(PlayListItemState state) =>
      Action(PlayControllerAction.updatePlayList, payload: state);
}
