import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class SongsListItemComponent extends Component<SongsListItemState> {
  SongsListItemComponent() 
    :super(
      reducer: null,
      effect: null,
      view: buildView,
    );
}
