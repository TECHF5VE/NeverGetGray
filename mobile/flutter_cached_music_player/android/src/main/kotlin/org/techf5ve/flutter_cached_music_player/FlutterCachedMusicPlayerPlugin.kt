package org.techf5ve.flutter_cached_music_player

import android.util.Log;

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

import org.techf5ve.flutter_cached_music_player.AndriodVideoCacheWrapper
import org.techf5ve.flutter_cached_music_player.ExoPlayerWrapper
import java.lang.Exception

class FlutterCachedMusicPlayerPlugin(val registrar: Registrar): MethodCallHandler {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_cached_music_player")
      channel.setMethodCallHandler(FlutterCachedMusicPlayerPlugin(registrar))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    try {
      when(call.method) {
        "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
        "initializeAudioCache" -> {
          Log.i("plugin", "brefore_initialize")
          AndriodVideoCacheWrapper.initialize(registrar.context())
        }
        "prepare" -> {
          Log.i("plugin", "brefore_prepare")
          Log.i("plugin", call.argument<String>("url")!!);
          ExoPlayerWrapper.prepare(call.argument<String>("url")!!, registrar.context(), registrar.activity())
          result.success(null)
          Log.i("plugin", call.argument<String>("url")!!);
        }
        "play" -> {
          ExoPlayerWrapper.play()
          result.success(null)
          Log.i("plugin", "play_internal");
        }
        "pause" -> {
          ExoPlayerWrapper.pause()
          result.success(null)
          Log.i("plugin", "pause_internal");
        }
        "stop" -> {
          ExoPlayerWrapper.pause()
          result.success(null)
          Log.i("plugin", "stop_internal");
        }
        else -> result.notImplemented()
      }
    } catch (e: Exception) {
      result.error("NATIVE_EXCEPTION", e.toString(), null)
    }
  }
}
