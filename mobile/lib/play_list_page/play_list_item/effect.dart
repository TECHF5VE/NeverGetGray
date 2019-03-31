import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';
import '../../songs_list_page/page.dart' as songsListPage;

import 'action.dart';
import 'state.dart';

Effect<PlayListItemState> buildEffect() {
  return combineEffects(<Object, Effect<PlayListItemState>>{
    PlayListItemAction.onNavigateToSongsList: _onNavigateToSongsList,
  });
}

void _onNavigateToSongsList(Action action, Context<PlayListItemState> ctx) {
  Navigator.of(ctx.context)
      .push(MaterialPageRoute<Map<String, String>>(
    builder: (buildCtx) => songsListPage.SongsListPage().buildPage(<String, dynamic> {
      'state': ctx.state,
    }),
  ));
}
