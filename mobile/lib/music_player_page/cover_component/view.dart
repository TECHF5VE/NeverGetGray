import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(CoverState pageState, Dispatch dispatch, ViewService viewService) {
  return RotationTransition(child: Container(
    width : 300.0,
    height: 300.0,
    decoration: BoxDecoration(
      shape:BoxShape.circle,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(pageState.coverUrl),
      )
    ),
  ),
  turns: AlwaysStoppedAnimation(pageState.imageAngle));
}
