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
    apiKey: 'AIzaSyDKMDacY7K5ssBXNQlep3W6APxV26MgJtc',
    appId: '1:135490803354:web:0866160887b96af284b123',
    messagingSenderId: '135490803354',
    projectId: 'countmygame-87e2b',
    authDomain: 'countmygame-87e2b.firebaseapp.com',
    storageBucket: 'countmygame-87e2b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBNVqevz65I6GKDAZmKrWj2lM-n5-OK7PE',
    appId: '1:135490803354:android:3a60751c97d6114884b123',
    messagingSenderId: '135490803354',
    projectId: 'countmygame-87e2b',
    storageBucket: 'countmygame-87e2b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBoa49ZIzllb41Ics7EImkVOzGjmFUQ31g',
    appId: '1:135490803354:ios:bb7f3120a124ccf084b123',
    messagingSenderId: '135490803354',
    projectId: 'countmygame-87e2b',
    storageBucket: 'countmygame-87e2b.appspot.com',
    iosBundleId: 'com.example.countMyGame',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBoa49ZIzllb41Ics7EImkVOzGjmFUQ31g',
    appId: '1:135490803354:ios:032571267ea246a584b123',
    messagingSenderId: '135490803354',
    projectId: 'countmygame-87e2b',
    storageBucket: 'countmygame-87e2b.appspot.com',
    iosBundleId: 'com.example.countMyGame.RunnerTests',
  );
}
