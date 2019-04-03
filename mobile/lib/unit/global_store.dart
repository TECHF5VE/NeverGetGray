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

  int songLength;
  int playingPosition;

  int bufferedLength;

  PlayQueueMode playQueueMode;
  PlayStatus playStatus;

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
      ..songLength = this.songLength
      ..playingPosition = this.playingPosition
      ..bufferedLength = this.bufferedLength
      ..playQueueMode = this.playQueueMode
      ..playStatus = this.playStatus;
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
    ..songLength = 0
    ..playingPosition = 0
    ..bufferedLength = 0
    ..playQueueMode = PlayQueueMode.Sequence
    ..playStatus = PlayStatus.Paused;
}

Reducer<AppState> _buildReducer() {
  return asReducer<AppState>({
    AppStoreAction.updateGlobalInfo: _updateGlobalInfoReducer,
    AppStoreAction.updatePlayList: _updatePlayListReducer,
    AppStoreAction.updatePlayIndex: _updatePlayIndexReducer,
    AppStoreAction.updatePlayStatus: _updatePlayStatusReducer,
    AppStoreAction.updatePlayQueueMode: _updatePlayQueueModeReducer,
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

enum AppStoreAction {
  updateGlobalInfo,
  updatePlayList,
  updatePlayIndex,
  updatePlayStatus,
  updatePlayQueueMode,
}

class AppStoreActionCreate {
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
}
