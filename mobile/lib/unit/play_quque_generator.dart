import 'dart:collection';
import 'dart:math';
import 'package:never_get_gray_mobile/songs_list_page/songs_list_item/state.dart';

import 'global_store.dart';

class PlayQueue {
  static const MAX_QUEUE_LENGTH = 20;

  factory PlayQueue() => _getInstance();
  static PlayQueue get instance => _getInstance();
  static PlayQueue _instance;

  Queue<SongsListItemState> _prePlayQueue;
  Queue<SongsListItemState> _playQueue;

  PlayQueue._internal() {
    _prePlayQueue = Queue();
    _playQueue = Queue();
  }

  static PlayQueue _getInstance() {
    if (_instance == null) {
      _instance = PlayQueue._internal();
    }
    return _instance;
  }

  SongsListItemState get nextSongInfo {
    final mode = GlobalStoreUtil.globalState.getState().playQueueMode;
    final playList = GlobalStoreUtil.globalState.getState().playList;
    final playIndex = GlobalStoreUtil.globalState.getState().playIndex;

    final currentSong = _playQueue.removeFirst();
    _prePlayQueue.addLast(currentSong);

    if (_prePlayQueue.length > MAX_QUEUE_LENGTH) {
      _prePlayQueue.removeFirst();
    }

    if (mode == PlayQueueMode.Sequence) {
      if (playIndex == playList.songs.length - 1) {
        return null;
      }
    } else if (mode == PlayQueueMode.Circle) {
      final nextIndex = (playIndex + 1) % playList.songs.length;
      _playQueue.add(playList.songs[nextIndex]);
    } else if (mode == PlayQueueMode.Random ||
        mode == PlayQueueMode.SingleLoop) {
      final random = Random();
      _playQueue.add(playList.songs[random.nextInt(playList.songs.length)]);
    }

    return _playQueue.first;
  }

  SongsListItemState get lastSongInfo {
    final mode = GlobalStoreUtil.globalState.getState().playQueueMode;
    final playList = GlobalStoreUtil.globalState.getState().playList;
    final playIndex = GlobalStoreUtil.globalState.getState().playIndex;

    if (_prePlayQueue.isNotEmpty) {
      final last = _prePlayQueue.removeLast();
      _playQueue.addFirst(last);
      return last;
    } else {
      if (mode == PlayQueueMode.Sequence) {
        if (playIndex == 0) {
          return null;
        }
        var lastIndex = playIndex - 1;
        _playQueue.addFirst(playList.songs[lastIndex]);
        _playQueue.removeLast();
        return _playQueue.first;
      } else if (mode == PlayQueueMode.Circle) {
        var lastIndex = playIndex - 1;
        if (lastIndex == -1) {
          lastIndex = playList.songs.length - 1;
        }
        _playQueue.addFirst(playList.songs[lastIndex]);
        _playQueue.removeLast();
        return _playQueue.first;
      } else if (mode == PlayQueueMode.Random ||
          mode == PlayQueueMode.SingleLoop) {
        final random = Random();
        _playQueue.add(playList.songs[random.nextInt(playList.songs.length)]);
        return _playQueue.first;
      }
    }
    return null;
  }

  void clearHistory() {
    _prePlayQueue.clear();
  }

  void generatePlayQueue() {
    if (_playQueue.isNotEmpty) {
      _playQueue = Queue.of([_playQueue.first]);
    }
    // _prePlayQueue.clear();
    final mode = GlobalStoreUtil.globalState.getState().playQueueMode;
    final playList = GlobalStoreUtil.globalState.getState().playList;
    final playIndex = GlobalStoreUtil.globalState.getState().playIndex;

    if (playIndex == -1) {
      return;
    }

    if (mode == PlayQueueMode.Sequence || mode == PlayQueueMode.Circle) {
      final end = min(playIndex + MAX_QUEUE_LENGTH, playList.songs.length);
      _playQueue = Queue.of(playList.songs.sublist(playIndex, end));
    } else if (mode == PlayQueueMode.Random ||
        mode == PlayQueueMode.SingleLoop) {
      final random = Random();
      var resultList = <SongsListItemState>[];

      resultList.add(playList.songs[playIndex]);

      for (var i = 0; i < MAX_QUEUE_LENGTH - 1; i++) {
        resultList.add(playList.songs[random.nextInt(playList.songs.length)]);
      }
      _playQueue = Queue.of(resultList);
    }
  }
}
