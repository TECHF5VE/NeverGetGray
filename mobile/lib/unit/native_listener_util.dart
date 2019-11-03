import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_cached_music_player/flutter_cached_music_player.dart';
import 'package:never_get_gray_mobile/unit/global_store.dart';

void listenToBufferPercentStream(Context<dynamic> ctx) {
  FlutterCachedMusicPlayer.listenToBufferPercentStream((percentage) async {
    print('percentage: $percentage');
    GlobalStoreUtil.globalState.dispatch(
        AppStateActionCreator.updateBufferedPercentageAction(percentage));
    AppProvider.appBroadcast(ctx.context,
        AppStateActionCreator.updateBufferedPercentageAction(percentage));
    if (percentage >= 100) {
      await FlutterCachedMusicPlayer.cancelBufferPercentStreamListen();
    }
  });
}
