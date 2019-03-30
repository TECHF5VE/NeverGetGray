package org.techf5ve.flutter_cached_music_player

import com.danikula.videocache.*
import android.content.Context
import android.util.Log
import java.io.File


object AndriodVideoCacheWrapper {
    private var proxyServer: HttpProxyCacheServer? = null
    private var currentUrl: String? = null

    fun initialize(ctx: Context) {
        proxyServer = getProxy(ctx)
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

    fun onListen() {
        proxyServer!!.registerCacheListener({cacheFile: File, url: String, percentsAvailable: Int ->

        }, currentUrl)
    }

    fun isAudioCached(url: String): Boolean {
        return proxyServer!!.isCached(url);
    }

}