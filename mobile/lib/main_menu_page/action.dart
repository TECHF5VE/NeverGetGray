import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:never_get_gray_mobile/play_list_page/play_list_item/state.dart';

import 'state.dart';

enum PageAction {
  initPage,
  onTabChangeAction,

  initError,
  initSuccess,
  initPending,

  updatePlayList,
  updateTabController,
}

class PageActionCreator {
  static Action onTabChangeAction(TagType newTagType) =>
      Action(PageAction.onTabChangeAction, payload: newTagType);
  static Action initPageAction() => const Action(PageAction.initPage);

  static Action initSuccessAction() => const Action(PageAction.initSuccess);
  static Action initPendingAction() => const Action(PageAction.initPending);
  static Action initErrorAction() => const Action(PageAction.initError);

  static Action updatePlayList(List<PlayListItemState> playListItems) =>
      Action(PageAction.updatePlayList, payload: playListItems);

  static Action updateTabController(TabController tabController) =>
      Action(PageAction.updateTabController, payload: tabController);
}
