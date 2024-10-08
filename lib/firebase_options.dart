// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAMtniJjMRv86WYVTAK0k_P41WrZCEyC_I',
    appId: '1:39397906344:web:1bd9da2d5dd530173f2f9d',
    messagingSenderId: '39397906344',
    projectId: 'cs2-throwings',
    authDomain: 'cs2-throwings.firebaseapp.com',
    storageBucket: 'cs2-throwings.appspot.com',
    measurementId: 'G-XT89VH51GK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBtfUXjK6qlrbicZOQZFQiUl_1MXLvvt7w',
    appId: '1:39397906344:android:f0bf8d72ba16edf43f2f9d',
    messagingSenderId: '39397906344',
    projectId: 'cs2-throwings',
    storageBucket: 'cs2-throwings.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1tFOyWCYqD2aeVNOaM6mH2i6ZTeivLGM',
    appId: '1:39397906344:ios:30fd32883d3b85d03f2f9d',
    messagingSenderId: '39397906344',
    projectId: 'cs2-throwings',
    storageBucket: 'cs2-throwings.appspot.com',
    iosBundleId: 'com.example.throwings',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA1tFOyWCYqD2aeVNOaM6mH2i6ZTeivLGM',
    appId: '1:39397906344:ios:30fd32883d3b85d03f2f9d',
    messagingSenderId: '39397906344',
    projectId: 'cs2-throwings',
    storageBucket: 'cs2-throwings.appspot.com',
    iosBundleId: 'com.example.throwings',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAMtniJjMRv86WYVTAK0k_P41WrZCEyC_I',
    appId: '1:39397906344:web:0fc171431568d4c63f2f9d',
    messagingSenderId: '39397906344',
    projectId: 'cs2-throwings',
    authDomain: 'cs2-throwings.firebaseapp.com',
    storageBucket: 'cs2-throwings.appspot.com',
    measurementId: 'G-SHD17G6DTB',
  );
}
