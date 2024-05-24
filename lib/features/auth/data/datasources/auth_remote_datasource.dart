import 'package:api_clean_arch/core/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

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
  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
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
      // Update the display name
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
