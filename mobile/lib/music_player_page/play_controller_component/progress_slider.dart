import 'package:flutter/material.dart';
import 'dart:math';

const double baseHeight = 650.0;

typedef void ProgressCallBack();
typedef void ProgressCallBackWithValue(double progressValue);

class ProgressSlider extends StatefulWidget {
  final double value;
  final double bufferedValue;
  final ProgressCallBack onDragStart;
  final ProgressCallBack onDragEnd;
  final ProgressCallBackWithValue onValueUpdated;

  ProgressSlider({
    @required this.onDragStart,
    @required this.onDragEnd,
    @required this.onValueUpdated,
    this.value = 0.0,
    this.bufferedValue = 0.0,
  });

  @override
  State<StatefulWidget> createState() => _ProgressSliderState(this.value);
}

class _ProgressSliderState extends State<ProgressSlider> {
  double _position = 0.0;
  double _value;

  _ProgressSliderState(double value) : _value = value;

  @override
  Widget build(BuildContext context) {
    this._value = this.widget.value;
    return Container(
        height: 12,
        child: LayoutBuilder(
          builder: (context, constrains) {
            this._position = this._value * (constrains.maxWidth - 10);
            return Stack(
              fit: StackFit.loose,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: SizedBox(
                    height: 4,
                    child: LinearProgressIndicator(
                      value: this.widget.bufferedValue,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      backgroundColor: Colors.blueGrey,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: SizedBox(
                    height: 4,
                    child: LinearProgressIndicator(
                      value: this._value,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.lightBlue),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Positioned(
                    left: this._position,
                    bottom: 0,
                    child: SizedBox(
                        height: 12,
                        child: GestureDetector(
                          onHorizontalDragStart: (details) =>
                              {this.widget.onDragStart()},
                          onHorizontalDragEnd: (details) =>
                              {this.widget.onDragEnd()},
                          onHorizontalDragUpdate: (details) {
                            _onPointDrag(details, constrains.maxWidth,
                                this.widget.bufferedValue);
                            this.widget.onValueUpdated(this._value);
                          },
                          child: new Container(
                            width: 10,
                            height: 10,
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )))
              ],
            );
          },
        ));
  }

  void _onPointDrag(
      DragUpdateDetails details, double maxWidth, double bufferdProgress) {
    this.setState(() {
      this._position += details.delta.dx;
      this._position =
          max(0, min(this._position, maxWidth * bufferdProgress - 10));
      this._value = this._position / (maxWidth - 10);
    });
  }
}
