import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDlClXZfEmshrrNdCefA4A3iAHbncXfCbM",
            authDomain: "ievangelize-firebase-2.firebaseapp.com",
            projectId: "ievangelize-firebase-2",
            storageBucket: "ievangelize-firebase-2.firebasestorage.app",
            messagingSenderId: "563043638760",
            appId: "1:563043638760:web:7097666718a91433f4d85d",
            measurementId: "G-VHHKJFREZP"));
  } else {
    await Firebase.initializeApp();
  }
}
