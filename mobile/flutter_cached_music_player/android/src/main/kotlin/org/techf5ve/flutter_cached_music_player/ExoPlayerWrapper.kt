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
import com.google.android.exoplayer2.upstream.DefaultDataSourceFactory
import com.google.android.exoplayer2.upstream.DefaultHttpDataSource
import com.google.android.exoplayer2.upstream.DefaultHttpDataSourceFactory
import com.google.android.exoplayer2.upstream.DefaultBandwidthMeter






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
//        val userAgent = Util.getUserAgent(activity, "AndroidVideoCache sample")
//        val dataSourceFactory = DefaultDataSourceFactory(activity, userAgent, bandwidthMeter)
//        val extractorsFactory = DefaultExtractorsFactory()
//        return ExtractorMediaSource(Uri.parse(url), dataSourceFactory, extractorsFactory, null, null)

//        val bandwidthMeter = DefaultBandwidthMeter()
//        val userAgent = Util.getUserAgent(ctx, "Never Get Grey")
//        val dataSourceFactory = DefaultDataSourceFactory(activity, userAgent, bandwidthMeter)
//        val extractorsFactory = DefaultExtractorsFactory()
//        return ExtractorMediaSource(Uri.parse(url), dataSourceFactory, extractorsFactory, bandwidthMeter, userAgent)

        val userAgent = Util.getUserAgent(ctx, "never-get-grey")
        val httpDataSourceFactory = DefaultHttpDataSourceFactory(
                userAgent,
                null /* listener */,
                DefaultHttpDataSource.DEFAULT_CONNECT_TIMEOUT_MILLIS,
                DefaultHttpDataSource.DEFAULT_READ_TIMEOUT_MILLIS,
                true /* allowCrossProtocolRedirects */
        )

        val dataSourceFactory = DefaultDataSourceFactory(
                ctx, null,
                httpDataSourceFactory
        )/* listener */

        return ExtractorMediaSource
                .Factory(dataSourceFactory)
                .createMediaSource(Uri.parse(url));
    }

}