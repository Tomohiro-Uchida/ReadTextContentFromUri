# read_text_content_from_uri

Read text content specified by URI.

## Getting Started

### Preparing pubspec.yaml
``` pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  read_text_content_from_uri:   <- Add here !!
```
### Dart Source code
```
import 'package:read_text_content_from_uri/read_text_content_from_uri.dart';

Uri uri = "content://....."

_readTextContentFromUriPlugin.execute(uri).then((value) {
    if (value != null) {
    setState(() {
        _sharedText = value;
    });
    }
    debugPrint(value);
});

```
