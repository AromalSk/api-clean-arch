// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:api_clean_arch/core/error/failures.dart';
import 'package:api_clean_arch/core/usecase/usecase.dart';
import 'package:api_clean_arch/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements UseCase<String, UserLoginParams> {
  final AuthRepository authRepository;
  UserLogin(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailAndPassword(
        email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;
  UserLoginParams({
    required this.email,
    required this.password,
  });
}
