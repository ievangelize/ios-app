import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDB5_k0kWr9D0-Vk2zfDDol4ebYZbApNxo",
            authDomain: "ievangelize-firebase-56350.firebaseapp.com",
            projectId: "ievangelize-firebase-56350",
            storageBucket: "ievangelize-firebase-56350.firebasestorage.app",
            messagingSenderId: "243229685241",
            appId: "1:243229685241:web:36187c5437d40e854b3928",
            measurementId: "G-YXFBPW2H6F"));
  } else {
    await Firebase.initializeApp();
  }
}
