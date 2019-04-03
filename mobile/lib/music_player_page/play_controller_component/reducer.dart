import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PlayControllerState> buildReducer() {
  return asReducer(
    <Object, Reducer<PlayControllerState>> {
      PlayControllerAction.updatePlayStatus: _updatePlayStatusReducer,
      PlayControllerAction.updatePlayQueueMode: _updatePlayQueueModeReducer,
    }
  );
}

PlayControllerState _updatePlayStatusReducer(PlayControllerState state, Action action) {
  final newState = state.clone();
  return newState..playStatus = action.payload;
}

PlayControllerState _updatePlayQueueModeReducer(PlayControllerState state, Action action) {
  final newState = state.clone();
  return newState..playQueueMode = action.payload;
}
