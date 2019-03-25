import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Widget buildView(PlayListItemState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: Text(state.name),
  );
}
