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
        return macos;
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
    apiKey: 'AIzaSyA8ODfHuq0LL9TavWahwRVYClFiZoLC-oY',
    appId: '1:226603353559:web:7205607d08733fffff7792',
    messagingSenderId: '226603353559',
    projectId: 'myinsta-5b1ee',
    authDomain: 'myinsta-5b1ee.firebaseapp.com',
    storageBucket: 'myinsta-5b1ee.appspot.com',
    measurementId: 'G-BNNFR2PM8B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4p7yHOdQ9wHeoU-SH8-_4zqwTZUyWeTc',
    appId: '1:226603353559:android:f9dcc366790dcbc9ff7792',
    messagingSenderId: '226603353559',
    projectId: 'myinsta-5b1ee',
    storageBucket: 'myinsta-5b1ee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7ePpa0a1HOVk7l5shjiRxjSGG4P1doC8',
    appId: '1:226603353559:ios:5654c169e69ed737ff7792',
    messagingSenderId: '226603353559',
    projectId: 'myinsta-5b1ee',
    storageBucket: 'myinsta-5b1ee.appspot.com',
    iosBundleId: 'com.example.myInsta',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC7ePpa0a1HOVk7l5shjiRxjSGG4P1doC8',
    appId: '1:226603353559:ios:ecae842702909979ff7792',
    messagingSenderId: '226603353559',
    projectId: 'myinsta-5b1ee',
    storageBucket: 'myinsta-5b1ee.appspot.com',
    iosBundleId: 'com.example.myInsta.RunnerTests',
  );
}