package org.techf5ve.flutter_cached_music_player

import android.content.Context
import android.app.Activity
import android.net.Uri
import android.util.Log

import com.google.android.exoplayer2.SimpleExoPlayer
import org.techf5ve.flutter_cached_music_player.AndriodVideoCacheWrapper
import com.google.android.exoplayer2.ExoPlayerFactory
import com.google.android.exoplayer2.DefaultLoadControl
import com.google.android.exoplayer2.LoadControl
import com.google.android.exoplayer2.trackselection.DefaultTrackSelector
import com.google.android.exoplayer2.trackselection.TrackSelector
import com.google.android.exoplayer2.trackselection.AdaptiveTrackSelection
import com.google.android.exoplayer2.trackselection.TrackSelection
import com.google.android.exoplayer2.source.ExtractorMediaSource
import com.google.android.exoplayer2.extractor.DefaultExtractorsFactory
import com.google.android.exoplayer2.extractor.ExtractorsFactory
import com.google.android.exoplayer2.util.Util.getUserAgent
import com.google.android.exoplayer2.source.MediaSource
import com.google.android.exoplayer2.upstream.*
import com.google.android.exoplayer2.util.Util;


object ExoPlayerWrapper {
    private var simpleExoPlayer: SimpleExoPlayer? = null

    fun prepare(url: String, ctx: Context, activity: Activity) {
        val proxy = AndriodVideoCacheWrapper.prepare(url)

        Log.i("pluginjj", proxy);

        if (simpleExoPlayer == null) {
            simpleExoPlayer = newSimpleExoPlayer(ctx)
        }

        val videoSource = newVideoSource(proxy!!, ctx, activity)
        simpleExoPlayer?.prepare(videoSource)
    }

    fun play() {
        simpleExoPlayer?.playWhenReady = true
    }

    fun pause() {
        simpleExoPlayer?.playWhenReady = false
    }

    fun stop() {
        simpleExoPlayer?.stop();
    }

    fun release() {
        simpleExoPlayer?.release()
    }

    private fun newSimpleExoPlayer(ctx: Context): SimpleExoPlayer {
        return ExoPlayerFactory.newSimpleInstance(ctx);
    }

    private fun newVideoSource(url: String, ctx: Context?, activity: Activity?): MediaSource {
//        val bandwidthMeter = DefaultBandwidthMeter()
//        val userAgent = Util.getUserAgent(ctx, "Never Get Grey")
//        val dataSourceFactory = DefaultDataSourceFactory(activity, userAgent, bandwidthMeter)
//        val extractorsFactory = DefaultExtractorsFactory()
//        return ExtractorMediaSource(Uri.parse(url), dataSourceFactory, extractorsFactory, )
        return ExtractorMediaSource
                .Factory(DefaultDataSourceFactory(ctx, "never-get-grey"))
                .createMediaSource(Uri.parse(url));
    }

}