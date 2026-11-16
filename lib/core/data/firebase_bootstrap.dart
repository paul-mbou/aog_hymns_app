import 'package:aog_hymns_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

abstract final class FirebaseBootstrap {
  static bool get isPlaceholder =>
      DefaultFirebaseOptions.currentPlatform.projectId ==
      DefaultFirebaseOptions.placeholderProjectId;

  static bool ready = false;

  static Future<void> initialize() async {
    if (isPlaceholder) return;
    try {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      ready = true;
    } catch (error) {
      ready = false;
      if (kDebugMode) {
        debugPrint('Firebase init failed');
      }
    }
  }
}
