import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../../unit/global_store.dart';
import 'state.dart';
import 'action.dart';
import 'progress_slider.dart';

const _iconSize = 54.0;

const _icons = [
  Icons.format_list_bulleted,
  Icons.all_inclusive,
  Icons.loop,
  Icons.repeat_one
];

Widget buildView(
    PlayControllerState state, Dispatch dispatch, ViewService viewService) {
  // print(state.playingPosition / state.contentLength);
  return Container(
    decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.3))),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  iconSize: _iconSize,
                  onPressed: () => dispatch(
                      PlayControllerActionCreator.onPlayLastSongAction()),
                  padding: const EdgeInsets.all(0),
                ),
                IconButton(
                  icon: state.playStatus != PlayStatus.Paused
                      ? Icon(Icons.pause)
                      : Icon(Icons.play_arrow),
                  iconSize: _iconSize,
                  onPressed: () {
                    final newState = state.playStatus == PlayStatus.Paused
                        ? PlayStatus.Playing
                        : PlayStatus.Paused;
                    dispatch(
                        PlayControllerActionCreator.onUpdatePlayStatusAction(
                            newState));
                        dispatch(PlayControllerActionCreator.updatePlayStatusAction(newState));
                    // GlobalStoreUtil.globalState.dispatch(
                    //     AppStateActionCreator.updatePlayStatus(newState));
                  },
                  padding: const EdgeInsets.all(0),
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  iconSize: _iconSize,
                  onPressed: () => dispatch(
                      PlayControllerActionCreator.onPlayNextSongAction()),
                  padding: const EdgeInsets.all(0),
                )
              ],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '00:30',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    ' / ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '02:30',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(_icons[state.playQueueMode.index]),
                      iconSize: _iconSize - 30,
                      onPressed: () => dispatch(PlayControllerActionCreator
                          .onUpdatePlayQueueModeAction(PlayQueueMode.values[
                              (state.playQueueMode.index + 1) %
                                  PlayQueueMode.values.length])),
                      padding: const EdgeInsets.all(0),
                    ),
                    IconButton(
                      icon: Icon(Icons.queue_music),
                      iconSize: _iconSize - 30,
                      onPressed: () {},
                      padding: const EdgeInsets.all(0),
                    ),
                  ],
                )),
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 40, right: 40, bottom: 0, top: 0),
          margin: EdgeInsets.only(bottom: 0),
          child: ProgressSlider(
            value: state.playingPosition / state.contentLength,
            bufferedValue: state.bufferedPercentage / 100.0,
            onDragEnd: () => print('drag end.'),
            onDragStart: () => print('drag start.'),
            onValueUpdated: (double progressValue) {},
          ),
        )
      ],
    ),
  );
}
