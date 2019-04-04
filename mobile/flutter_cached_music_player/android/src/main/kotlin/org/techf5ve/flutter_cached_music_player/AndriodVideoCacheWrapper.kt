package org.techf5ve.flutter_cached_music_player

import android.app.Activity
import com.danikula.videocache.*
import android.content.Context
import android.util.Log
import io.flutter.plugin.common.EventChannel
import io.flutter.view.FlutterView
import java.io.File


object AndriodVideoCacheWrapper {
    private val STREAM = BuildConfig.APPLICATION_ID + "/buffer_percent_stream";

    private var proxyServer: HttpProxyCacheServer? = null
    var currentUrl: String? = null
    private var listener: CacheListener? = null

    fun initialize(activity: FlutterView, ctx: Context) {
        if (proxyServer != null) {
            return
        }
        proxyServer = getProxy(ctx)
        EventChannel(activity, STREAM).setStreamHandler(object: EventChannel.StreamHandler {
            override fun onListen(args: Any?, events: EventChannel.EventSink?) {
                listener = CacheListener { cacheFile: File, url: String, percentsAvailable: Int ->
                    events!!.success(percentsAvailable)
                };
                proxyServer!!.registerCacheListener(listener, currentUrl)
            }

            override fun onCancel(args: Any?) {
                proxyServer!!.unregisterCacheListener(listener)
            }
        })
    }

    private fun getProxy(ctx: Context): HttpProxyCacheServer {
        if (proxyServer == null) {
            proxyServer = HttpProxyCacheServer.Builder(ctx)
                    .maxCacheSize(1024 * 1024 * 512)
                    .maxCacheFilesCount(20)
                    .build()
        }
        return proxyServer!!
    }

    fun prepare(audioUrl: String): String? {
        currentUrl = audioUrl
        val proxyUrl = proxyServer?.getProxyUrl(audioUrl);
        return proxyUrl;
    }

    fun isAudioCached(url: String): Boolean {
        return proxyServer!!.isCached(url);
    }

    fun release() {
        proxyServer!!.unregisterCacheListener(listener)
    }

}