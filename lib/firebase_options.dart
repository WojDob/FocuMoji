// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAF1xNWT-6KTO80SV9h5BdmdHyhnrdFIQs',
    appId: '1:70146942065:web:df6881bb57a7ca1f06a7d0',
    messagingSenderId: '70146942065',
    projectId: 'focumoji',
    authDomain: 'focumoji.firebaseapp.com',
    storageBucket: 'focumoji.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCb3UvOzAzTqMB1aa0nHPBBUac1M6B_YYU',
    appId: '1:70146942065:android:2448c3d530ffd8d706a7d0',
    messagingSenderId: '70146942065',
    projectId: 'focumoji',
    storageBucket: 'focumoji.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2uZcfQ_dJRyeapS1nKFkX3yY3yUav5sU',
    appId: '1:70146942065:ios:5dc58a50fa664c3206a7d0',
    messagingSenderId: '70146942065',
    projectId: 'focumoji',
    storageBucket: 'focumoji.appspot.com',
    iosClientId: '70146942065-u4gvat51luve8e8av9fe3a31t75ao2ht.apps.googleusercontent.com',
    iosBundleId: 'com.example.focumoji',
  );
}
