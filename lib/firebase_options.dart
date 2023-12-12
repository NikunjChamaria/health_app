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
    apiKey: 'AIzaSyCpTFxYaKJksa6STXTu9PiGvGuBkSuKExE',
    appId: '1:805088373520:web:5d89c13286ef979427d395',
    messagingSenderId: '805088373520',
    projectId: 'health-app-fd812',
    authDomain: 'health-app-fd812.firebaseapp.com',
    storageBucket: 'health-app-fd812.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAGPTSmbbVRKbrMdOaWIO1ZKMNTAuvHYG0',
    appId: '1:805088373520:android:26daf8aac781668f27d395',
    messagingSenderId: '805088373520',
    projectId: 'health-app-fd812',
    storageBucket: 'health-app-fd812.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB57Hptns3Cw-IsCaRxTVMPzpzyyZ3bZ6s',
    appId: '1:805088373520:ios:bba8e627a24b89bc27d395',
    messagingSenderId: '805088373520',
    projectId: 'health-app-fd812',
    storageBucket: 'health-app-fd812.appspot.com',
    iosBundleId: 'com.example.healthApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB57Hptns3Cw-IsCaRxTVMPzpzyyZ3bZ6s',
    appId: '1:805088373520:ios:644db40970e8402a27d395',
    messagingSenderId: '805088373520',
    projectId: 'health-app-fd812',
    storageBucket: 'health-app-fd812.appspot.com',
    iosBundleId: 'com.example.healthApp.RunnerTests',
  );
}
