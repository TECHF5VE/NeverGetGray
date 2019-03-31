import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';
import 'reducer.dart';
import 'effect.dart';

class LogInPage extends Page<LogInState, Map<String, dynamic>> {
  LogInPage()
    : super(
      initState: initState,
      effect: buildEffect(),
      reducer: buildReducer(),
      view: buildView,
      dependencies : null,
    );
}
