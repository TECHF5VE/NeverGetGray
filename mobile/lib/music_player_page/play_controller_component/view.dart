import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';
import 'progress_slider.dart';

const _iconSize = 54.0;

Widget buildView(
    PlayControllerState state, Dispatch dispatch, ViewService viewService) {
  return Column(
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
                onPressed: () {},
                padding: const EdgeInsets.all(0),
              ),
              IconButton(
                icon: Icon(Icons.play_arrow),
                iconSize: _iconSize,
                onPressed: () {},
                padding: const EdgeInsets.all(0),
              ),
              IconButton(
                icon: Icon(Icons.skip_next),
                iconSize: _iconSize,
                onPressed: () {},
                padding: const EdgeInsets.all(0),
              )
            ],
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
              Text('00:30', style: TextStyle(fontSize: 18),),
              Text(' / ', style: TextStyle(fontSize: 18),),
              Text('02:30', style: TextStyle(fontSize: 18),)
            ],),
          ),
          Container(
              padding: EdgeInsets.only(left: 0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.repeat_one),
                    iconSize: _iconSize - 30,
                    onPressed: () {},
                    padding: const EdgeInsets.all(0),
                  ),
                  IconButton(
                    icon: Icon(Icons.playlist_play),
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
          value: 0.3,
          bufferedValue: 0.5,
          onDragEnd: () => print('drag end.'),
          onDragStart: () => print('drag start.'),
          onValueUpdated: (double progressValue) {},
        ),
      )
    ],
  );
}
