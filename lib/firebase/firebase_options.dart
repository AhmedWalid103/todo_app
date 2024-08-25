import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
 ///import 'firebase_options.dart';

/// await Firebase.initializeApp(
  /// options: DefaultFirebaseOptions.currentPlatform,
 ///) {


// }
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
    apiKey: 'AIzaSyArZ21HExuKnDjvDcyCnhxUY5AdwGRNC04',
    appId: '1:724877066017:web:16e0f723bf766ad2c28860',
    messagingSenderId: '724877066017',
    projectId: 'todo-app-b5a56',
    authDomain: 'todo-app-b5a56.firebaseapp.com',
    storageBucket: 'todo-app-b5a56.appspot.com',
    measurementId: 'G-616FS5WJWS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAFkDHuypSh7dh7IAHHOptDV9CjE-cKhJY',
    appId: '1:724877066017:android:0531f4cc391e4583c28860',
    messagingSenderId: '724877066017',
    projectId: 'todo-app-b5a56',
    storageBucket: 'todo-app-b5a56.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCLLGDmS4reLp3PWA7YSvlBpVlMaS0YGLU',
    appId: '1:724877066017:ios:21af869bdd1feb6bc28860',
    messagingSenderId: '724877066017',
    projectId: 'todo-app-b5a56',
    storageBucket: 'todo-app-b5a56.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCLLGDmS4reLp3PWA7YSvlBpVlMaS0YGLU',
    appId: '1:724877066017:ios:21af869bdd1feb6bc28860',
    messagingSenderId: '724877066017',
    projectId: 'todo-app-b5a56',
    storageBucket: 'todo-app-b5a56.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyArZ21HExuKnDjvDcyCnhxUY5AdwGRNC04',
    appId: '1:724877066017:web:1712bbba12ae933fc28860',
    messagingSenderId: '724877066017',
    projectId: 'todo-app-b5a56',
    authDomain: 'todo-app-b5a56.firebaseapp.com',
    storageBucket: 'todo-app-b5a56.appspot.com',
    measurementId: 'G-DJW64EEQHS',
  );

}