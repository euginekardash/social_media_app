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
    apiKey: 'AIzaSyDVDWF_lTNXjsP_W1mqc2dPWovf7I9bjPs',
    appId: '1:101783663499:web:a0b641f103053f6280358e',
    messagingSenderId: '101783663499',
    projectId: 'social-media-5c9bb',
    authDomain: 'social-media-5c9bb.firebaseapp.com',
    storageBucket: 'social-media-5c9bb.appspot.com',
    measurementId: 'G-7G9VTN7YW3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFTa2u0V-C4L_CmNFGxJ6HfRlapFRkCF8',
    appId: '1:101783663499:android:865e246c43076d3880358e',
    messagingSenderId: '101783663499',
    projectId: 'social-media-5c9bb',
    storageBucket: 'social-media-5c9bb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBptNhxe4rcXlgysfNqsm_0fAr6Jme1Eio',
    appId: '1:101783663499:ios:50b8793cec8b8b4780358e',
    messagingSenderId: '101783663499',
    projectId: 'social-media-5c9bb',
    storageBucket: 'social-media-5c9bb.appspot.com',
    iosBundleId: 'com.kardash.socialMedia',
  );
}