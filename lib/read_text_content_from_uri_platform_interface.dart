import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'read_text_content_from_uri_method_channel.dart';

abstract class ReadTextContentFromUriPlatform extends PlatformInterface {
  /// Constructs a ReadTextContentFromUriPlatform.
  ReadTextContentFromUriPlatform() : super(token: _token);

  static final Object _token = Object();

  static ReadTextContentFromUriPlatform _instance = MethodChannelReadTextContentFromUri();

  /// The default instance of [ReadTextContentFromUriPlatform] to use.
  ///
  /// Defaults to [MethodChannelReadTextContentFromUri].
  static ReadTextContentFromUriPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ReadTextContentFromUriPlatform] when
  /// they register themselves.
  static set instance(ReadTextContentFromUriPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> execute(Uri uri) {
    throw UnimplementedError('execute() has not been implemented.');
  }
}
