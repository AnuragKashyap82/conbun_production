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
    apiKey: 'AIzaSyAxr4UZbJqTVi5WMyfbO-PDb-J5qWCVnd4',
    appId: '1:554125480057:web:370137a3ac5d2b685544a8',
    messagingSenderId: '554125480057',
    projectId: 'conbun829',
    authDomain: 'conbun829.firebaseapp.com',
    storageBucket: 'conbun829.firebasestorage.app',
    measurementId: 'G-3E9DV7C9C8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-KJy1B1-hprxA5ccnHWm9H5Fvc3IDgMQ',
    appId: '1:554125480057:android:f82d075c466673135544a8',
    messagingSenderId: '554125480057',
    projectId: 'conbun829',
    storageBucket: 'conbun829.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCRHCNkY4dfpYhAzPQaIWpy-8foOHNBwGA',
    appId: '1:554125480057:ios:31422b43f54ca09d5544a8',
    messagingSenderId: '554125480057',
    projectId: 'conbun829',
    storageBucket: 'conbun829.firebasestorage.app',
    iosBundleId: 'com.conbun.user',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCRHCNkY4dfpYhAzPQaIWpy-8foOHNBwGA',
    appId: '1:554125480057:ios:156ef78e120196495544a8',
    messagingSenderId: '554125480057',
    projectId: 'conbun829',
    storageBucket: 'conbun829.firebasestorage.app',
    iosBundleId: 'com.conbun.user',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAxr4UZbJqTVi5WMyfbO-PDb-J5qWCVnd4',
    appId: '1:554125480057:web:8c6c34f58bb1e8045544a8',
    messagingSenderId: '554125480057',
    projectId: 'conbun829',
    authDomain: 'conbun829.firebaseapp.com',
    storageBucket: 'conbun829.firebasestorage.app',
    measurementId: 'G-RYSPSL669K',
  );

}