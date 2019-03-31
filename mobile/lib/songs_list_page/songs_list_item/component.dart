import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'view.dart';

class SongsListItemComponent extends Component<SongsListItemState> {
  SongsListItemComponent() 
    :super(
      reducer: buildReducer(),
      effect: buildEffect(),
      view: buildView,
    );
}
