import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_cached_music_player/flutter_cached_music_player.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_cached_music_player');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterCachedMusicPlayer.platformVersion, '42');
  });
}
