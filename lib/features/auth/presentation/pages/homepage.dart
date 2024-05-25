import 'package:api_clean_arch/core/utils/show_snackbar.dart';
import 'package:api_clean_arch/features/auth/presentation/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  showSnackBar(context, "User has been logged out");
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ), (route) => false);
                },
                icon: Icon(Icons.exit_to_app),
                label: Text("Logout")),
          )
        ],
      ),
    );
  }
}
