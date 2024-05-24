import 'package:api_clean_arch/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:api_clean_arch/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:api_clean_arch/features/auth/domain/repository/auth_repository.dart';
import 'package:api_clean_arch/features/auth/domain/usecases/user_signup.dart';
import 'package:api_clean_arch/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  await Firebase.initializeApp();

  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()));

  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()));

  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));

  serviceLocator
      .registerLazySingleton(() => AuthBloc(userSignUp: serviceLocator()));
}
