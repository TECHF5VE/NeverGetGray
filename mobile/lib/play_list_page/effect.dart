import 'package:fish_redux/fish_redux.dart';
import 'package:never_get_gray_mobile/play_list_page/play_list_item/state.dart';

import 'action.dart';
import 'state.dart';

import '../unit/global_store.dart';
import '../unit/playing_progress_timer_generator.dart';


Effect<PlayListState> buildEffect() {
  return combineEffects(<Object, Effect<PlayListState>> {
    Lifecycle.initState: _onAppear,
    Lifecycle.appear: _onAppear,
  });
}

void _onAppear(Action action, Context<PlayListState> ctx) async {
  if (GlobalStoreUtil.globalState.getState().playIndex != -1) {
    if (GlobalStoreUtil.globalState.getState().playingProgressTimer != null) {
      GlobalStoreUtil.globalState.getState().playingProgressTimer.cancel();
      GlobalStoreUtil.globalState
          .dispatch(AppStateActionCreator.updatePlayingProgressTimer(null));
    }
    generatePlayingProcessTimer(ctx);
  }
}

