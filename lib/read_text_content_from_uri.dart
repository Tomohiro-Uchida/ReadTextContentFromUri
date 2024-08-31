
import 'read_text_content_from_uri_platform_interface.dart';

class ReadTextContentFromUri {
  Future<String?> execute(Uri uri) {
    return ReadTextContentFromUriPlatform.instance.execute(uri);
  }
}
