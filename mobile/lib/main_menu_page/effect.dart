import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:never_get_gray_mobile/play_list_page/play_list_item/state.dart';
import 'package:never_get_gray_mobile/songs_list_page/songs_list_item/state.dart';

import 'action.dart';
import 'state.dart';

import 'package:never_get_gray_mobile/unit/network.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../unit/global_store.dart';

Effect<PageState> buildEffect() {
  return combineEffects(<Object, Effect<PageState>>{
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<PageState> ctx) async {
  ctx.dispatch(PageActionCreator.initPendingAction());
  try {
    final response = await NetWorkUnit.get(
        GlobalStoreUtil.globalState.getState().ipAddr,
        'playlists',
        GlobalStoreUtil.globalState.getState().port, {
      'auth_key': GlobalStoreUtil.globalState.getState().authKey,
    });

    if (response.data['code'] == '200') {
      // print(response.data['data']);

      List<PlayListItemState> playListItems = [];
      final playLists = response.data['data']['playlist'] as List<dynamic>;
      for (final playList in playLists) {
        List<SongsListItemState> songsListItems = [];
        final songsLists = playList['songs'];
        for (final songs in songsLists) {
          songsListItems.add(SongsListItemState()
            ..uid = songs['uid']
            ..name = songs['name']
            ..album = songs['album']
            ..albumImg = ''
            ..artist = songs['artist']);
        }

        playListItems.add(PlayListItemState()
          ..name = playList['name']
          ..uid = playList['uid']
          ..songs = songsListItems);
      }

      for (final playListItem in playListItems) {
        if (playListItem.songs.isNotEmpty) {
          try {
            final firstSong = playListItem.songs[0];
            final albumResponse = await NetWorkUnit.get(
              GlobalStoreUtil.globalState.getState().ipAddr,
              'songs/${firstSong.uid}',
              GlobalStoreUtil.globalState.getState().port,
              {'auth_key': GlobalStoreUtil.globalState.getState().authKey},
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
