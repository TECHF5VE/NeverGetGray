import 'package:fish_redux/fish_redux.dart';

import 'view.dart';
import 'reducer.dart';
import 'effect.dart';
import 'state.dart';

class PlayControllerComponent extends Component<PlayControllerState> {
  PlayControllerComponent()
    : super(
      view: buildView,
      effect: buildEffect(),
      reducer: buildReducer(),
    );
}
