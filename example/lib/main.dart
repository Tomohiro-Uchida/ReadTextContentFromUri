import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:read_text_content_from_uri/read_text_content_from_uri.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _readTextContentFromUriPlugin = ReadTextContentFromUri();
  late StreamSubscription _intentDataStreamSubscription;
  String? _sharedText;

  @override
  void initState() {
    super.initState();
    _intentDataStreamSubscription = FlutterSharingIntent.instance.getMediaStream().listen((List<SharedFile> value) {
      String strUri = value.map((f) => f.value).join();
      if (strUri.isNotEmpty) {
        Uri uri = Uri.parse(strUri);
        _readTextContentFromUriPlugin.execute(uri).then((value) {
          if (value != null) {
            setState(() {
              _sharedText = value;
            });
          }
          debugPrint(value);
        });
      } else {
        debugPrint("Uri is empty.");
      }
    }, onError: (err) {
      debugPrint("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    FlutterSharingIntent.instance.getInitialSharing().then((List<SharedFile> value) {
      String strUri = value.map((f) => f.value).join();
      if (strUri.isNotEmpty) {
        Uri uri = Uri.parse(strUri);
        _readTextContentFromUriPlugin.execute(uri).then((value) {
          if (value != null) {
            setState(() {
              _sharedText = value;
            });
          }
          debugPrint(value);
        });
      } else {
        debugPrint("Uri is empty.");
      }
    });
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Text(_sharedText ?? "SharedText was not gotten."),
        )
    );
  }
}
