import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_cached_music_player/flutter_cached_music_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _currentPlayState = 'stopped';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initAudioPlayer();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterCachedMusicPlayer.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future initAudioPlayer() async {
    try {
      await FlutterCachedMusicPlayer.initializeAudioCache();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Running on: $_platformVersion\n'),
              Text('Current play state: $_currentPlayState'),
              RaisedButton(
                child: Text('Play music'),
                elevation: 1,
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () async {
                  if (_currentPlayState == 'stopped') {
                    await FlutterCachedMusicPlayer.prepare(
                        'http://www.ytmp3.cn/down/59626.mp3');
                    setState(() {
                      _currentPlayState = 'preparing';
                    });
                  }
                  await FlutterCachedMusicPlayer.play();
                  setState(() {
                    _currentPlayState = 'playing';
                  });
                  print('played');
                },
              ),
              RaisedButton(
                child: Text('Pause music'),
                elevation: 1,
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () async {
                  await FlutterCachedMusicPlayer.pause();
                  setState(() {
                    _currentPlayState = 'paused';
                  });
                  print('paused');
                },
              ),
              RaisedButton(
                child: Text('Stop music'),
                elevation: 1,
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () async {
                  await FlutterCachedMusicPlayer.pause();
                  setState(() {
                    _currentPlayState = 'stopped';
                  });
                  print('stopped');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
