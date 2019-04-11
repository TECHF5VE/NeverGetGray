import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:never_get_gray_mobile/play_list_page/play_list_item/state.dart';
import 'package:never_get_gray_mobile/songs_list_page/songs_list_item/state.dart';
import '../unit/playing_progress_timer_generator.dart';

import 'action.dart';
import 'state.dart';
import 'stfstate.dart';

import 'package:never_get_gray_mobile/unit/network.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_cached_music_player/flutter_cached_music_player.dart';


Effect<PageState> buildEffect() {
  return combineEffects(<Object, Effect<PageState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
  });
}

void _dispose(Action action, Context<PageState> ctx) {
  ctx.state.tabController.dispose();
}

void _init(Action action, Context<PageState> ctx) async {
  final tabController =
      TabController(vsync: ctx.stfState as PageStfState, length: 3);

  tabController.addListener(() {
    ctx.dispatch(PageActionCreator.onTabChangeAction(
        TagType.values[tabController.index]));
  });

  ctx.dispatch(PageActionCreator.updateTabController(tabController));
  ctx.dispatch(PageActionCreator.initPendingAction());

  await FlutterCachedMusicPlayer.initializeAudioCache();

  try {
    final response = await NetWorkUnit.get(
        ctx.state.appState.ipAddr, 'playlists', ctx.state.appState.port, {
      'auth_key': ctx.state.appState.authKey,
    });

    if (response.data['code'] == '200') {
      // print(response.data['data']);

      List<PlayListItemState> playListItems = [];
      final playLists = response.data['data']['playlist'] as List<dynamic>;
      for (final playList in playLists) {
        List<SongsListItemState> songsListItems = [];
        final songsLists = playList['songs'];
        var index = 0;
        for (final songs in songsLists) {
          songsListItems.add(SongsListItemState(ctx.state.appState)
            ..uid = songs['uid']
            ..name = songs['name']
            ..album = songs['album']
            ..albumImg = ''
            ..index = index++
            ..lyrics = ''
            ..artist = songs['artist']
            ..isPlaying = false);
        }

        playListItems.add(PlayListItemState(ctx.state.appState)
          ..name = playList['name']
          ..uid = playList['uid']
          ..songs = songsListItems);
      }

      for (final playListItem in playListItems) {
        if (playListItem.songs.isNotEmpty) {
          try {
            final firstSong = playListItem.songs[0];
            final albumResponse = await NetWorkUnit.get(
              ctx.state.appState.ipAddr,
              'songs/${firstSong.uid}',
              ctx.state.appState.port,
              {'auth_key': ctx.state.appState.authKey},
            );
            if (albumResponse.data['code'] == '200') {
              firstSong.albumImg = albumResponse.data['data']['album_img'];
              firstSong.lyrics = albumResponse.data['data']['lyrics'];
            }
          } catch (e) {
            print(e);
          }
        }
      }

      ctx.dispatch(PageActionCreator.updatePlayList(playListItems));
      ctx.dispatch(PageActionCreator.initSuccessAction());

      //TODO: save new play lists.
    } else {
      //TODO: Load local play lists.
      Fluttertoast.showToast(
        msg:
            'Failed to get play list from server, app will run under offline mode.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 5,
        backgroundColor: Color.fromRGBO(240, 240, 240, 30),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      ctx.dispatch(PageActionCreator.initErrorAction());
    }
  } catch (e) {
    Fluttertoast.showToast(
      msg:
          'Failed to get play list from server, app will run under offline mode.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 2,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    ctx.dispatch(PageActionCreator.initErrorAction());
  }

  return;
}
