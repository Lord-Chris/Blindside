import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthenticationService {
  /// [Future]<[void]> Signs up the user with the given [email] and [password].
  ///
  /// Parameters: [String]email, [String]password
  Future<void> signUpWithEmailAndPassword(String email, String password);

  /// [Future]<[void]> Signs in the user with given [email] and [password]
  ///
  /// Parameters: [String]email, [String]password
  Future<void> signInWithEmailAndPassword(String email, String password);

  /// [Future]<[void]> Signs the currently logged in user out of the app
  ///
  /// Parameters: null
  Future<void> logOut();

  // returns the details of the current user
  User? get currentUser;
}
