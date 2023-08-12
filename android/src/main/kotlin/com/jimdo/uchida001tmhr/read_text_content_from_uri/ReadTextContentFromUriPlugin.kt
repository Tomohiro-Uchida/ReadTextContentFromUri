package com.jimdo.uchida001tmhr.read_text_content_from_uri

import android.content.Context
import android.content.Intent.FLAG_GRANT_READ_URI_PERMISSION
import android.net.Uri

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.BufferedReader
import java.io.FileNotFoundException
import java.io.IOException
import java.io.InputStream
import java.io.InputStreamReader

/** ReadTextContentFromUriPlugin */
class ReadTextContentFromUriPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var appContext: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.jimdo.uchida001tmhr/read_text_content_from_uri")
    channel.setMethodCallHandler(this)
    appContext = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    var inputStream: InputStream? = null
    var jsonContent = ""
    var buffer: StringBuffer? = null

    if (call.method == "execute") {
      val uri = Uri.parse(call.argument("UriString"))
      try {
        appContext.grantUriPermission("com.jimdo.uchida001tmhr.read_text_content_from_uri", uri, FLAG_GRANT_READ_URI_PERMISSION);
        inputStream = appContext.contentResolver.openInputStream(uri)
        if (inputStream != null) {
          buffer = StringBuffer()
          val reader = BufferedReader(InputStreamReader(inputStream))
          var str: String?
          while (reader.readLine().also { str = it } != null) {
            buffer.append(str)
          }
        }
        jsonContent = buffer.toString()
        result.success(jsonContent)
      } catch (e: FileNotFoundException) {
        result.error("-1", "FileNotFoundException", "Couldn't open file.")
      } catch (e: IOException) {
        result.error("-2", "IOException", "Couldn't read/write file.")
      } finally {
        inputStream?.close()
        appContext.revokeUriPermission(uri, FLAG_GRANT_READ_URI_PERMISSION)
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
