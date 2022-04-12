import 'package:blindside/core/models/_models.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'i_authentication_service.dart';

class AuthenticationService implements IAuthenticationService {
  final _auth = FirebaseAuth.instance;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Failure('User not found');
      } else if (e.code == 'wrong-password') {
        throw Failure('Wrong password');
      } else {
        throw Failure('Something went wrong');
      }
    } catch (e) {
      throw Failure('Something went wrong');
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Failure('Email already in use');
      } else if (e.code == 'invalid-email') {
        throw Failure('Invalid email');
      } else if (e.code == 'weak-password') {
        throw Failure('Weak password');
      } else {
        throw Failure('Something went wrong');
      }
    } catch (e) {
      throw Failure('Something went wrong');
    }
  }

  @override
  Future<void> logOut() async {
    await _auth.signOut();
  }

  @override
  User? get currentUser => _auth.currentUser;
}
