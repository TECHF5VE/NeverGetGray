import 'package:fish_redux/fish_redux.dart';

class AppState implements Cloneable<AppState> {
  String userName;
  String ipAddr;
  String port;
  String authKey;

  @override
  AppState clone() {
    return AppState()
      ..userName = this.userName
      ..ipAddr = this.ipAddr
      ..port = this.port
      ..authKey = this.authKey;
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
    ..authKey = '';
}

Reducer<AppState> _buildReducer() {
  return asReducer<AppState>({
    AppStoreAction.updateGlobalInfo: _updateGlobalInfoReducer,
  });
}

AppState _updateGlobalInfoReducer(AppState state, Action action) {
  final payload = action.payload as Map<String, String>;
  return AppState()
    ..userName = payload['userName']
    ..ipAddr = payload['ipAddr']
    ..port = payload['port']
    ..authKey = payload['authKey'];
}

enum AppStoreAction {
  updateGlobalInfo,
}

class AppStoreActionCreate {
  static Action updateGlobalInfoAction(Map<String, String> info) =>
      Action(AppStoreAction.updateGlobalInfo, payload: info);
}
