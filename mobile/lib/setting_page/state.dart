import 'package:fish_redux/fish_redux.dart';

class SettingState implements Cloneable<SettingState> {

  @override
  SettingState clone() {
    var newState = SettingState();

    return newState;
  }
}
