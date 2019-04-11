import 'package:fish_redux/fish_redux.dart';
import 'package:never_get_gray_mobile/unit/global_store.dart';

class SettingState extends AppSubState implements Cloneable<SettingState> {
  SettingState(AppState state) : super(state);

  @override
  SettingState clone() {
    var newState = SettingState(this.appState);

    return newState;
  }
}
