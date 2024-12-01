import 'package:flutter/material.dart';
import 'package:lab_assessment_1/customTextField.dart';
import 'package:lab_assessment_1/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab_assessment_1/models/user.dart';

import '../services/firebase_service.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});


  @override
  Widget build(BuildContext context) {
    TextEditingController emailController=TextEditingController();
    TextEditingController passwordController= TextEditingController();
    TextEditingController nameController= TextEditingController();
    return Scaffold(
      body:Column(
        children: [
          Container(
            height: 300,
            color: Colors.purple,
          ),
          Column(
            children: [
              const SizedBox(height: 40,),

              Customtextfield(
                icon: Icons.email_outlined,
                ltext: 'name',
                htext: 'bobba',
                controller: nameController,
                obsecureText: false,
                validator:(value){
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                } ,
              ),
              const SizedBox(height: 20,),
            Customtextfield(
              icon: Icons.email_outlined,
              ltext: 'Email',
              htext: 'e.g bibo@example.com',
              controller: emailController,
              obsecureText: false,
              validator:(value){
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              } ,
            ),
            const SizedBox(height: 20,),
            Customtextfield(
              obsecureText: false,
              controller: passwordController,
              ltext: 'Password',
              htext: '*******',
              icon: Icons.lock,
              validator:(value){
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Await the sign-up process
                    await authService().signUp(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    final currentUser = authService().currentUser;

                    if (currentUser != null) {
                      try {
                        await FirestoreService().addData('Users', {
                          'name': nameController.text,
                          'id': currentUser.uid,
                          'email': currentUser.email,
                        });
                        print("User added successfully!");
                      } catch (e) {
                        print("Failed to add user: $e");
                      }
                    } else {
                      print("User sign-up successful, but currentUser is null.");
                    }

                  } on FirebaseAuthException catch (e) {
                    print("Sign-up error: ${e.message}");
                  }
                },
                child: const Text('Sign Up'),
              )

            ],
          ),
        ],
      ),
    );
  }
}
