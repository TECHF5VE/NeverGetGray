import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import '../../unit/global_store.dart';

enum PlayControllerAction {
  onUpdatePlayStatus,
  updatePlayStatus,

  onUpdatePlayQueueMode,
  updatePlayQueueMode,

  onPlayNextSong,
  onPlayLastSong,

  // TODO: remove this after update fish-redux.
  updatePlayStatusProxyWorkaround,

  updateBufferdPercentage,
  updatePlayingPosition,
  updateContentLength,
}

class PlayControllerActionCreator {
  static Action onUpdatePlayStatusAction(PlayStatus status) =>
      Action(PlayControllerAction.onUpdatePlayStatus, payload: status);
  static Action updatePlayStatusAction(PlayStatus status) =>
      Action(PlayControllerAction.updatePlayStatus, payload: status);
  static Action updatePlayStatusWorkAroundAction(PlayStatus status) =>
      Action(PlayControllerAction.updatePlayStatusProxyWorkaround,
          payload: status);

  static Action onUpdatePlayQueueModeAction(PlayQueueMode mode) =>
      Action(PlayControllerAction.onUpdatePlayQueueMode, payload: mode);
  static Action updatePlayQueueModeAction(PlayQueueMode mode) =>
      Action(PlayControllerAction.updatePlayQueueMode, payload: mode);

  static Action onPlayNextSongAction() =>
      Action(PlayControllerAction.onPlayNextSong);

  static Action onPlayLastSongAction() =>
      Action(PlayControllerAction.onPlayLastSong);

  static Action updateBufferdPercentage(int percentage) =>
      Action(PlayControllerAction.updateBufferdPercentage, payload: percentage);

  static Action updatePlayingPosition(int position) =>
      Action(PlayControllerAction.updatePlayingPosition, payload: position);

  static Action updateContentLength(int length) =>
      Action(PlayControllerAction.updateContentLength, payload: length);
}
