import 'dart:async';

import 'package:flutter/services.dart';

class FlutterCachedMusicPlayer {
  static const MethodChannel _channel =
      const MethodChannel('flutter_cached_music_player');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future initializeAudioCache() async {
    return _channel.invokeMethod('initializeAudioCache');
  }

  static Future prepare(String url) async {
    return _channel.invokeMethod('prepare', <String, String>{
      'url': url,
    });
  }

  static Future play() async {
    return _channel.invokeMethod('play');
  }

  static Future pause() async {
    return _channel.invokeMethod('pause');
  }

  static Future stop() async {
    return _channel.invokeMethod('stop');
  }

  static Future<bool> isCached(String url) async {
    return _channel.invokeMethod('isCached', {
      'url': url,
    });
  }

  static Future<bool> isCurrentCached(String url) async {
    return _channel.invokeMethod('isCurrentCached');
  }

  static Future<int> get musicContentLength async =>
      await _channel.invokeMethod('getDuration');

  static Future<int> get currentPlayingPosition async =>
      await _channel.invokeMethod('getCurrentPosition');

  static const EventChannel _eventChannel = const EventChannel(
      'org.techf5ve.flutter_cached_music_player/buffer_percent_stream');

  static StreamSubscription<dynamic> _subscription;

  static void listenToBufferPercentStream(void onData(dynamic event),
      {Function onError, void onDone(), bool cancelOnError}) {
    _subscription = _eventChannel.receiveBroadcastStream().listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  static Future<void> cancelBufferPercentStreamListen() async {
    if (_subscription == null) {
      return;
    }
    await _subscription.cancel();
    _subscription = null;
  }
}
