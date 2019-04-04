import 'package:fish_redux/fish_redux.dart';
import 'package:never_get_gray_mobile/play_list_page/play_list_item/state.dart';
import 'package:never_get_gray_mobile/unit/global_store.dart';
import 'package:never_get_gray_mobile/unit/playing_progress_timer_generator.dart';

// import 'action.dart';
// import 'state.dart';

Effect<PlayListItemState> buildEffect() {
  return combineEffects(<Object, Effect<PlayListItemState>> {
    Lifecycle.initState: _onAppear,
    Lifecycle.appear: _onAppear,
  });
}

void _onAppear(Action action, Context<PlayListItemState> ctx) async {
  if (GlobalStoreUtil.globalState.getState().playIndex != -1) {
    if (GlobalStoreUtil.globalState.getState().playingProgressTimer != null) {
      GlobalStoreUtil.globalState.getState().playingProgressTimer.cancel();
      GlobalStoreUtil.globalState
          .dispatch(AppStateActionCreator.updatePlayingProgressTimer(null));
    }
    generatePlayingProcessTimer(ctx);
  }
}
