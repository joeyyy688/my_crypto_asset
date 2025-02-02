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
    apiKey: 'AIzaSyBpiyBVOXr6RisxEQUBR_gUBOsfml9bWH0',
    appId: '1:1016521705873:web:dbde7f399b8b5512f2b230',
    messagingSenderId: '1016521705873',
    projectId: 'my-crypto-app-89d87',
    authDomain: 'my-crypto-app-89d87.firebaseapp.com',
    storageBucket: 'my-crypto-app-89d87.appspot.com',
    measurementId: 'G-N9Y9Q37Q50',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC2WzJ12ASZPi1QX12zZ-uY2En4yipwR5o',
    appId: '1:1016521705873:android:81b16fc3dddbaa27f2b230',
    messagingSenderId: '1016521705873',
    projectId: 'my-crypto-app-89d87',
    storageBucket: 'my-crypto-app-89d87.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDwtgFV9KHlvlaPiZGSImFEkKOpfxGx1JQ',
    appId: '1:1016521705873:ios:14f437bc1e05b608f2b230',
    messagingSenderId: '1016521705873',
    projectId: 'my-crypto-app-89d87',
    storageBucket: 'my-crypto-app-89d87.appspot.com',
    iosBundleId: 'com.example.myCryptoAsset',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDwtgFV9KHlvlaPiZGSImFEkKOpfxGx1JQ',
    appId: '1:1016521705873:ios:14f437bc1e05b608f2b230',
    messagingSenderId: '1016521705873',
    projectId: 'my-crypto-app-89d87',
    storageBucket: 'my-crypto-app-89d87.appspot.com',
    iosBundleId: 'com.example.myCryptoAsset',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBpiyBVOXr6RisxEQUBR_gUBOsfml9bWH0',
    appId: '1:1016521705873:web:daa18d4b184d1063f2b230',
    messagingSenderId: '1016521705873',
    projectId: 'my-crypto-app-89d87',
    authDomain: 'my-crypto-app-89d87.firebaseapp.com',
    storageBucket: 'my-crypto-app-89d87.appspot.com',
    measurementId: 'G-02KGGF1ZGN',
  );
}
