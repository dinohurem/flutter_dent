import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_provider/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create doctor object based on Firebase user.
  Doctor? _doctorFromFirebaseUser(User? user) {
    // ignore: unnecessary_null_comparison
    return user != null
        ? Doctor(
            uid: user.uid,
          )
        : null;
  }

  // Auth change user stream.
  Stream<Doctor?> get doctor {
    return _auth.authStateChanges().map(_doctorFromFirebaseUser);
  }

  // Sign in anonymously.
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _doctorFromFirebaseUser(user!);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  // Sign in with email/password.

  // Register with email/password.

  // Sign out.
}
