import 'package:api_clean_arch/core/secrets/app_secrets.dart';
import 'package:api_clean_arch/core/theme/theme.dart';
import 'package:api_clean_arch/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:api_clean_arch/features/auth/presentation/pages/login_page.dart';
import 'package:api_clean_arch/features/cats/data/datasources/api_remote_datasource.dart';
import 'package:api_clean_arch/features/cats/data/repositories/cats_repository_impl.dart';
import 'package:api_clean_arch/features/cats/domain/usecases/get_cats.dart';
import 'package:api_clean_arch/features/cats/presentation/bloc/cats_bloc.dart';
import 'package:api_clean_arch/features/cats/presentation/pages/cats_list.dart';
import 'package:api_clean_arch/init_dependencies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
          create: (_) => CatsBloc(
              getCats: GetCats(CatRepositoryImpl(ApiRemoteDataSourceImpl()))))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.darkThemeMode,
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CatsGridPage();
              } else {
                return LoginPage();
              }
            }));
  }
}
