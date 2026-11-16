import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Placeholder AOG Firebase project. Replace with `flutterfire configure`.
/// Initialization is skipped while [FirebaseBootstrap.isPlaceholder] is true,
/// so a missing project shows the empty state instead of crashing.
class DefaultFirebaseOptions {
  static const placeholderProjectId = 'aog-hymns-placeholder';

  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        return android;
    }
  }

  static const android = FirebaseOptions(
    apiKey: 'placeholder',
    appId: '1:000000000000:android:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: placeholderProjectId,
    storageBucket: 'aog-hymns-placeholder.appspot.com',
  );

  static const ios = FirebaseOptions(
    apiKey: 'placeholder',
    appId: '1:000000000000:ios:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: placeholderProjectId,
    storageBucket: 'aog-hymns-placeholder.appspot.com',
    iosBundleId: 'com.apps_industry.aog_hymns',
  );
}
