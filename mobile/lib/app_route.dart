import 'package:fish_redux/fish_redux.dart';
import 'package:never_get_gray_mobile/log_in_page/page.dart';
import 'package:never_get_gray_mobile/log_in_page/state.dart';
import 'package:never_get_gray_mobile/play_list_page/play_list_item/state.dart';

import 'package:never_get_gray_mobile/register_page/page.dart';
import 'package:never_get_gray_mobile/register_page/state.dart';

import 'package:never_get_gray_mobile/main_menu_page/page.dart';
import 'package:never_get_gray_mobile/main_menu_page/state.dart';

import 'package:never_get_gray_mobile/songs_list_page/page.dart';
import 'package:never_get_gray_mobile/songs_list_page/state.dart';

import 'unit/global_store.dart' as globalStore;

class AppRoute {
  static AbstractRoutes _global;

  static AbstractRoutes get global {
    if (_global == null) {
      _global = AppRoutes(
          preloadedState: globalStore.initState(),
          reducer: _buildReducer(),
          pages: {
            RoutePath.login: LogInConnector() + LogInPage(),
            RoutePath.register: RegisterConnector() + RegisterPage(),
            RoutePath.main: MainMenuConnector() + MainMenuPage(),
            RoutePath.songsList: SongListConnector() + SongsListPage(),
          });
    }
    return _global;
  }
}

class RoutePath {
  static const String login = 'login';
  static const String register = 'register';
  static const String main = 'main';
  static const String songsList = 'songs_list';
}

enum AppStateAction {
  updatePlayListItemAction,
}

class AppStateActionCreator {
  static Action updatePlayListItemAction(PlayListItemState songsListItem) =>
      Action(AppStateAction.updatePlayListItemAction, payload: songsListItem);
}

Reducer<globalStore.AppState> _buildReducer() {
  return asReducer(<Object, Reducer<globalStore.AppState>>{
    AppStateAction.updatePlayListItemAction: _updatePlayListItemReducer,
  });
}

globalStore.AppState _updatePlayListItemReducer(
        globalStore.AppState state, Action action) =>
    state.clone()..songsListState = action.payload;
