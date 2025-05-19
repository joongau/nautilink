import 'package:firebase_auth/firebase_auth.dart';

/// Repository handling authentication logic using FirebaseAuth.
class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  /// Sign in using email and password.
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Sign out the current user.
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
  /// Stream of auth state changes (signed in user or null).
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
}