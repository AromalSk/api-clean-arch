import 'package:api_clean_arch/core/common/widgets/loader.dart';
import 'package:api_clean_arch/core/theme/app_pallete.dart';
import 'package:api_clean_arch/core/utils/show_snackbar.dart';
import 'package:api_clean_arch/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:api_clean_arch/features/auth/presentation/pages/homepage.dart';
import 'package:api_clean_arch/features/auth/presentation/pages/signup_page.dart';
import 'package:api_clean_arch/features/auth/presentation/widgets/auth_field.dart';
import 'package:api_clean_arch/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnackBar(context, state.message);
              }
              if (state is AuthSuccess) {
                showSnackBar(context, "User Logged In");
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Home();
                  },
                ));
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Loader();
              }
              return SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 150,
                      ),
                      const Text(
                        'Login.',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AuthField(
                        hintText: 'Email',
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AuthField(
                        hintText: 'Password',
                        controller: passwordController,
                        isObscureText: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthGradientButton(
                        buttonText: 'Login',
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            context.read<AuthBloc>().add(AuthLogin(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim()));
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return SignUpPage();
                            },
                          ));
                        },
                        child: RichText(
                            text: TextSpan(
                                text: 'Don\'t have an account? ',
                                style: Theme.of(context).textTheme.titleMedium,
                                children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: AppPallete.gradient2,
                                        fontWeight: FontWeight.bold),
                              )
                            ])),
                      )
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
