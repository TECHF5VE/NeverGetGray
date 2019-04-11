import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PlayControllerState> buildReducer() {
  return asReducer(<Object, Reducer<PlayControllerState>>{
    PlayControllerAction.updatePlayStatus: _updatePlayStatusReducer,
    PlayControllerAction.updatePlayQueueMode: _updatePlayQueueModeReducer,
    PlayControllerAction.updateBufferdPercentage: _updateBufferedPercentage,
    PlayControllerAction.updateContentLength: _updateContentLength,
    PlayControllerAction.updatePlayingPosition: _updatePlayingPosition,
    PlayControllerAction.updatePlayIndex: _udpatePlayIndexReducer,
    PlayControllerAction.updatePlayingProgressTimer:
        _updatePlayingProgressTimerReducer,
    PlayControllerAction.updatePlayList: _updatePlayListReducer,
  });
}

PlayControllerState _updatePlayStatusReducer(
    PlayControllerState state, Action action) {
  final newState = state.clone();
  return newState..playStatus = action.payload;
}

PlayControllerState _updatePlayQueueModeReducer(
    PlayControllerState state, Action action) {
  final newState = state.clone();
  return newState..playQueueMode = action.payload;
}

PlayControllerState _updateBufferedPercentage(
    PlayControllerState state, Action action) {
  final newState = state.clone();
  return newState..bufferedPercentage = action.payload;
}

PlayControllerState _updateContentLength(
    PlayControllerState state, Action action) {
  final newState = state.clone();
  return newState..contentLength = action.payload;
}

PlayControllerState _updatePlayingPosition(
    PlayControllerState state, Action action) {
  final newState = state.clone();
  return newState..playingPosition = action.payload;
}

PlayControllerState _udpatePlayIndexReducer(
    PlayControllerState state, Action action) {
  final newState = state.clone();
  return newState..playIndex = action.payload;
}

PlayControllerState _updatePlayingProgressTimerReducer(
    PlayControllerState state, Action action) {
  final newState = state.clone();
  return newState..playingProgressTimer = action.payload;
}

PlayControllerState _updatePlayListReducer(
    PlayControllerState state, Action action) {
  final newState = state.clone();
  return newState..playList = action.payload;
}
