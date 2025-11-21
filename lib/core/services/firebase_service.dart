import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static FirebaseAuth get auth => FirebaseAuth.instance;
  
  static Future<void> initialize() async {
    // Firebase configuration will be done in firebase_options.dart
    // For now, we'll just ensure Firebase is initialized
    await Firebase.initializeApp();
  }
}