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
    apiKey: 'AIzaSyAncwn5RTg52bjPMKDm87V1CHIpNinwR8I',
    appId: '1:434558826919:web:d923c35da65f0f1f131e82',
    messagingSenderId: '434558826919',
    projectId: 'flutterauth-8f30b',
    authDomain: 'flutterauth-8f30b.firebaseapp.com',
    storageBucket: 'flutterauth-8f30b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTUkqYS9yGc_gjUZ0Hg6iYIfQk-PTAhbc',
    appId: '1:434558826919:android:760dc58e6a14317c131e82',
    messagingSenderId: '434558826919',
    projectId: 'flutterauth-8f30b',
    storageBucket: 'flutterauth-8f30b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBstnVyzqQPXwaRSjI-ZFTA_bjTae5W1Ro',
    appId: '1:434558826919:ios:4988d2e35250434c131e82',
    messagingSenderId: '434558826919',
    projectId: 'flutterauth-8f30b',
    storageBucket: 'flutterauth-8f30b.appspot.com',
    iosBundleId: 'com.example.flutterauth',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBstnVyzqQPXwaRSjI-ZFTA_bjTae5W1Ro',
    appId: '1:434558826919:ios:4988d2e35250434c131e82',
    messagingSenderId: '434558826919',
    projectId: 'flutterauth-8f30b',
    storageBucket: 'flutterauth-8f30b.appspot.com',
    iosBundleId: 'com.example.flutterauth',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAncwn5RTg52bjPMKDm87V1CHIpNinwR8I',
    appId: '1:434558826919:web:d37a6ff6e37f7788131e82',
    messagingSenderId: '434558826919',
    projectId: 'flutterauth-8f30b',
    authDomain: 'flutterauth-8f30b.firebaseapp.com',
    storageBucket: 'flutterauth-8f30b.appspot.com',
  );
}
