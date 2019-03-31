import 'package:fish_redux/fish_redux.dart';

import 'view.dart';
// import 'reducer.dart';
import 'effect.dart';
import 'state.dart';

class PlayListItemComponent extends Component<PlayListItemState> {
  PlayListItemComponent()
    : super(
      view: buildView,
      effect: buildEffect(),
      reducer: null,
    );
}
