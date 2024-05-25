import 'package:api_clean_arch/core/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  AuthRemoteDataSourceImpl(this.firebaseAuth);
  User? get currentUserSession => firebaseAuth.currentUser;
  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential response = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw ServerException("User is null");
      }
      return response.user!.uid;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential response =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await response.user!.updateDisplayName(name);

      if (response.user == null) {
        throw ServerException("User is null");
      }
      return response.user!.uid;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
