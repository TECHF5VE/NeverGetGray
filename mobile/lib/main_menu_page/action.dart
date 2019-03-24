import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

enum PageAction {
  initPage,
  onTabChangeAction,
}

class PageActionCreator {
  static Action onTabChangeAction(TagType newTagType) => Action(PageAction.onTabChangeAction, payload: newTagType);
  static Action initPageAction() => const Action(PageAction.initPage);
}
