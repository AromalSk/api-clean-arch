import 'package:api_clean_arch/core/theme/theme.dart';
import 'package:api_clean_arch/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:api_clean_arch/features/auth/presentation/pages/login_page.dart';
import 'package:api_clean_arch/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      )
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
        home: LoginPage());
  }
}