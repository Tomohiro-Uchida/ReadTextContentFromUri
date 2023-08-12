import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'read_text_content_from_uri_platform_interface.dart';

/// An implementation of [ReadTextContentFromUriPlatform] that uses method channels.
class MethodChannelReadTextContentFromUri extends ReadTextContentFromUriPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('com.jimdo.uchida001tmhr/read_text_content_from_uri');

  @override
  Future<String?> execute(Uri uri) async {
    Map<String, String> args = {"UriString": uri.toString()};
    final result = await methodChannel.invokeMethod<String>('execute', args);
    return result;
  }
}
