import 'package:fish_redux/fish_redux.dart';

import 'view.dart';
import 'reducer.dart';
import 'effect.dart';
import 'state.dart';

class CoverComponent extends Component<CoverState> {
  CoverComponent()
    : super(
      view: buildView,
      effect: buildEffect(),
      reducer: buildReducer(),
    );
}
