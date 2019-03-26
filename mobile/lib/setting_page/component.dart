import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'view.dart';

class SettingComponent extends Component<SettingState> {
  SettingComponent() :
    super(
      view: buildView,
      effect: null,
      reducer: null,
    );
}
