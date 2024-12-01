import 'package:flutter/material.dart';
import 'package:lab_assessment_1/screens/homepage.dart';
import 'package:lab_assessment_1/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:lab_assessment_1/providers/is_logged_in_provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to the isLogged provider
   // final isLoggedProvider = Provider.of<isLogged>(context);

    return Scaffold(
      body: context.watch<isLogged>().isLoggedIn ?  WorkoutsPage() : const LoginScreen(),
    );
  }
}
