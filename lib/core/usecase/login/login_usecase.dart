import 'package:firebase_auth/firebase_auth.dart';

class LoginUsecase {
  Future<void> signIn(String email, String password) async {
    final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final token = await cred.user!.getIdTokenResult(true); // force refresh
    if (token.claims?['role'] != 'admin') {
      await FirebaseAuth.instance.signOut();
      throw FirebaseAuthException(
        code: 'not-admin',
        message: 'Access denied: Admin privileges required.',
      );
    }
  }
}
