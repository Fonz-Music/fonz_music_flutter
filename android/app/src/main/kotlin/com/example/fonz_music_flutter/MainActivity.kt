package com.example.fonz_music_flutter

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter

import android.net.Uri
import android.app.Activity

import android.os.Bundle;

import android.nfc.NfcAdapter
import android.app.PendingIntent

import io.flutter.plugins.GeneratedPluginRegistrant
import android.app.Application


class MainActivity: FlutterActivity() {

    private val SPOTIFYCHANNEL = "SpotifySignIn"
    private val SHARECHANNEL = "ShareSheet"
    private val INSTAGRAMCHANNEL = "ShareOnInstagram"
    var YourApplicationInstance = false

    @Override
    override protected fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val sharedPref = activity?.getPreferences(Context.MODE_PRIVATE) ?: return
        YourApplicationInstance = sharedPref.getBoolean("YourApplicationInstance", false)


        if (!YourApplicationInstance) {
            // Run your thread or do something else you want to do only once.
            val intent: Intent = getIntent()
            val action: String = intent.getAction().toString()
            val type: String = intent.getType().toString()
            if (intent == null) {
                GeneratedPluginRegistrant.registerWith(FlutterEngine(applicationContext))
//            configureFlutterEngine(flutterEngine)
            }
            // Set the wasCalled flag to true to not run this code again
            // if onCreate() is called a second time.
            YourApplicationInstance = true;
        }
//        val isEnabled = Settings.System.getInt(this.getApplicationContext().getContentResolver(), Settings.System.AIRPLANE_MODE_ON, 0) === 1

    }
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        if (intent == null) {
            GeneratedPluginRegistrant.registerWith(FlutterEngine(applicationContext))
//            configureFlutterEngine(flutterEngine)
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // sign into spotify
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SPOTIFYCHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "signIntoSpotify") {


            } else {
                result.notImplemented()
            }
        }

        // launch share sheet
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SHARECHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "launchShareSheet") {

                val urlLink = call.argument<String>("url")

                val sendIntent: Intent = Intent().apply {
                    action = Intent.ACTION_SEND
                    putExtra(Intent.EXTRA_TEXT, urlLink)
                    type = "text/uri-list"
                }

                val shareIntent = Intent.createChooser(sendIntent, null)
                startActivity(shareIntent)

                result.success("success")

            } else {
                result.notImplemented()
            }
        }

        // share on ig
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, INSTAGRAMCHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "shareOnInstagram") {

                // gets parameters
                println("starting this")

                // gets parameters
                val songTitle: String? = call.argument("songTitle")
                val songArtist: String? = call.argument("songArtist")
                val albumArt: String? = call.argument("albumArt")

                // Define image asset URI
                val stickerAssetUri: Uri = Uri.parse("assets/fonzIcons/mountainProfile.png")
                val sourceApplication = "com.fonzmusic.fonz"

                // Instantiate implicit intent with ADD_TO_STORY action,
                // sticker asset, and background colors
                val intent = Intent("com.instagram.share.ADD_TO_STORY")
                intent.putExtra("source_application", sourceApplication)

                intent.setType("image/*")
                intent.putExtra("interactive_asset_uri", stickerAssetUri)
                intent.putExtra("top_background_color", "#FF9425")
                intent.putExtra("bottom_background_color", "#B188B9")

                // Instantiate activity and verify it will resolve implicit intent
                val activity: Activity = getActivity()
                activity.grantUriPermission(
                        "com.instagram.android", stickerAssetUri, Intent.FLAG_GRANT_READ_URI_PERMISSION)
                if (activity.getPackageManager().resolveActivity(intent, 0) != null) {
                    activity.startActivityForResult(intent, 0)
                    println("success in method")
                }
                else {
                    println("epic fail")
                }


                result.success("success")

            } else {
                result.notImplemented()
            }
        }

    }







}

