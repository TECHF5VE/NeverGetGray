import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import '../songs_list_page/songs_list_item/state.dart';
import '../play_list_page/play_list_item/state.dart';

enum PlayQueueMode {
  Sequence,
  Random,
  Circle,
  SingleLoop,
}

enum PlayStatus {
  Playing,
  Paused,
  Loading,
}

class AppState implements Cloneable<AppState> {
  String userName;
  String ipAddr;
  String port;
  String authKey;

  PlayListItemState playList;
  List<SongsListItemState> playQueue;
  int playIndex;

  int contentLength;
  int playingPosition;

  int bufferedPercentage;
  bool isBufferd;

  PlayQueueMode playQueueMode;
  PlayStatus playStatus;

  Timer playingProgressTimer;

  @override
  AppState clone() {
    return AppState()
      ..userName = this.userName
      ..ipAddr = this.ipAddr
      ..port = this.port
      ..authKey = this.authKey
      ..playIndex = this.playIndex
      ..playQueue = this.playQueue
      ..playList = this.playList
      ..contentLength = this.contentLength
      ..playingPosition = this.playingPosition
      ..bufferedPercentage = this.bufferedPercentage
      ..playQueueMode = this.playQueueMode
      ..playStatus = this.playStatus
      ..playingProgressTimer = this.playingProgressTimer;
  }
}

class GlobalStoreUtil {
  static Store<AppState> _globalState;

  static Store<AppState> get globalState {
    if (_globalState == null) {
      _globalState = createStore(_initState(), _buildReducer());
    }

    return _globalState;
  }
}

AppState _initState() {
  return AppState()
    ..userName = ''
    ..ipAddr = ''
    ..port = ''
    ..authKey = ''
    ..playIndex = -1
    ..playQueue = []
    ..playList = null
    ..contentLength = 1
    ..playingPosition = 0
    ..bufferedPercentage = 0
    ..playQueueMode = PlayQueueMode.Sequence
    ..playStatus = PlayStatus.Paused
    ..playingProgressTimer = null;
}

Reducer<AppState> _buildReducer() {
  return asReducer<AppState>({
    AppStoreAction.updateGlobalInfo: _updateGlobalInfoReducer,
    AppStoreAction.updatePlayList: _updatePlayListReducer,
    AppStoreAction.updatePlayIndex: _updatePlayIndexReducer,
    AppStoreAction.updatePlayStatus: _updatePlayStatusReducer,
    AppStoreAction.updatePlayQueueMode: _updatePlayQueueModeReducer,
    AppStoreAction.updateBufferedPercentage: _updateBufferedPercentageReducer,
    AppStoreAction.updatePlayingPosition: _updatePlayingPositionAction,
    AppStoreAction.updateContentLength: _updateContentLengthReducer,
    AppStoreAction.updatePlayingProgressTimer: _updatePlayingProgressTimer,
  });
}

AppState _updateGlobalInfoReducer(AppState state, Action action) {
  final payload = action.payload as Map<String, String>;
  final newState = state.clone();
  return newState
    ..userName = payload['userName']
    ..ipAddr = payload['ipAddr']
    ..port = payload['port']
    ..authKey = payload['authKey'];
}

AppState _updatePlayListReducer(AppState state, Action action) {
  final payload = action.payload as PlayListItemState;
  final newState = state.clone();
  return newState..playList = payload;
}

AppState _updatePlayIndexReducer(AppState state, Action action) {
  final payload = action.payload as int;
  final newState = state.clone();
  return newState..playIndex = payload;
}

AppState _updatePlayStatusReducer(AppState state, Action action) {
  final payload = action.payload as PlayStatus;
  final newState = state.clone();
  return newState..playStatus = payload;
}

AppState _updatePlayQueueModeReducer(AppState state, Action action) {
  final payload = action.payload as PlayQueueMode;
  final newState = state.clone();
  return newState..playQueueMode = payload;
}

AppState _updateBufferedPercentageReducer(AppState state, Action action) {
  final payload = action.payload as int;
  final newState = state.clone();
  return newState..bufferedPercentage = payload;
}

AppState _updateContentLengthReducer(AppState state, Action action) {
  final payload = action.payload as int;
  final newState = state.clone();
  return newState..contentLength = payload;
}

AppState _updatePlayingPositionAction(AppState state, Action action) {
  final payload = action.payload as int;
  final newState = state.clone();
  return newState..playingPosition = payload;
}

AppState _updatePlayingProgressTimer(AppState state, Action action) {
  final payload = action.payload as Timer;
  final newState = state.clone();
  return newState..playingProgressTimer = payload;
}

enum AppStoreAction {
  updateGlobalInfo,
  updatePlayList,
  updatePlayIndex,
  updatePlayStatus,
  updatePlayQueueMode,
  updateBufferedPercentage,
  updateContentLength,
  updatePlayingPosition,
  updatePlayingProgressTimer,
}

class AppStateActionCreator {
  static Action updateGlobalInfoAction(Map<String, String> info) =>
      Action(AppStoreAction.updateGlobalInfo, payload: info);
  static Action updatePlayListAction(PlayListItemState state) =>
      Action(AppStoreAction.updatePlayList, payload: state);
  static Action updatePlayIndexAction(int index) =>
      Action(AppStoreAction.updatePlayIndex, payload: index);
  static Action updatePlayStatus(PlayStatus status) =>
      Action(AppStoreAction.updatePlayStatus, payload: status);
  static Action updatePlayQueueMode(PlayQueueMode mode) =>
      Action(AppStoreAction.updatePlayQueueMode, payload: mode);
  static Action updateBufferedPercentageAction(int percentage) =>
      Action(AppStoreAction.updateBufferedPercentage, payload: percentage);
  static Action updatePlayingPositionAction(int position) =>
      Action(AppStoreAction.updatePlayingPosition, payload: position);
  static Action updateContentLength(int contentLength) =>
      Action(AppStoreAction.updateContentLength, payload: contentLength);
  static Action updatePlayingProgressTimer(Timer timer) {
    return Action(AppStoreAction.updatePlayingProgressTimer, payload: timer);
  }
}
