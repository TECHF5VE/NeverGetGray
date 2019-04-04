import 'package:fish_redux/fish_redux.dart';

class SongsListState implements Cloneable<SongsListState> {

  @override
  SongsListState clone() {
    var newState = SongsListState();

    return newState;
  }
}

SongsListState initState(Map<String, dynamic> args) {
  return SongsListState();
}