import 'package:flutter_test/flutter_test.dart';
import 'package:read_text_content_from_uri/read_text_content_from_uri.dart';
import 'package:read_text_content_from_uri/read_text_content_from_uri_platform_interface.dart';
import 'package:read_text_content_from_uri/read_text_content_from_uri_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockReadTextContentFromUriPlatform
    with MockPlatformInterfaceMixin
    implements ReadTextContentFromUriPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ReadTextContentFromUriPlatform initialPlatform = ReadTextContentFromUriPlatform.instance;

  test('$MethodChannelReadTextContentFromUri is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelReadTextContentFromUri>());
  });

  test('getPlatformVersion', () async {
    ReadTextContentFromUri readTextContentFromUriPlugin = ReadTextContentFromUri();
    MockReadTextContentFromUriPlatform fakePlatform = MockReadTextContentFromUriPlatform();
    ReadTextContentFromUriPlatform.instance = fakePlatform;

    expect(await readTextContentFromUriPlugin.getPlatformVersion(), '42');
  });
}
