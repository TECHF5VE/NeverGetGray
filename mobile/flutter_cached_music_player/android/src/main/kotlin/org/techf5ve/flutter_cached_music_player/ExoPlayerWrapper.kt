package org.techf5ve.flutter_cached_music_player

import android.content.Context
import android.app.Activity
import android.net.Uri
import android.util.Log
import com.google.android.exoplayer2.*

import org.techf5ve.flutter_cached_music_player.AndriodVideoCacheWrapper
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
import io.flutter.plugin.common.EventChannel
import io.flutter.view.FlutterView

object ExoPlayerWrapper {
    private var simpleExoPlayer: SimpleExoPlayer? = null
    final val STERAM = BuildConfig.APPLICATION_ID + "/play_process_stream";

    fun prepare(url: String, ctx: Context, activity: FlutterView) {
        val proxy = AndriodVideoCacheWrapper.prepare(url)

        if (simpleExoPlayer == null) {
            simpleExoPlayer = newSimpleExoPlayer(ctx)
            EventChannel(activity, STERAM).setStreamHandler(object: EventChannel.StreamHandler {
                override fun onListen(args: Any?, events: EventChannel.EventSink?) {
                     simpleExoPlayer!!.addListener(object: Player.EventListener {

                     })//To change body of created functions use File | Settings | File Templates.
                }

                override fun onCancel(p0: Any?) {
                    TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
                }

            })
        }

        val videoSource = newVideoSource(proxy!!, ctx)
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

    val duration: Long
        get() = simpleExoPlayer!!.duration

    var currentPosition: Long
        get() = simpleExoPlayer!!.currentPosition
        set(value) = simpleExoPlayer!!.seekTo(value)

    private fun newSimpleExoPlayer(ctx: Context): SimpleExoPlayer {
        return ExoPlayerFactory.newSimpleInstance(ctx);
    }

    private fun newVideoSource(url: String, ctx: Context?): MediaSource {
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