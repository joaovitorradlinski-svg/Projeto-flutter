import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (!kIsWeb) {
      throw UnsupportedError(
        'Este app está configurado APENAS para Firebase Web.',
      );
    }
    return web;
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyBYomOPj6-3NJlfl9LF-yRPKylxZwNU1k0",
    authDomain: "rpgconfig.firebaseapp.com",
    projectId: "rpgconfig",
    storageBucket: "rpgconfig.appspot.com",
    messagingSenderId: "513796145552",
    appId: "1:513796145552:web:1918d17d576f8292197315",
    measurementId: "G-9CXVPMXCTF",
  );
}
