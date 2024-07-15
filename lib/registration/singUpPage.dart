import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learningfirebase/registration/login.dart';
import 'package:learningfirebase/screen/home_scren.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

  void signUpAction() async {
    final String name = _fullnameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String cPassword = _cPasswordController.text.trim();

    if (name == "" || email == "" || password == "" || cPassword == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all the fields"),
        ),
      );
      log("please fill all the fields");
    } else if (password != cPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password doesn't match"),
        ),
      );
      log("Password doesn't match");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user!.email != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const HomeScreen();
          }));
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Sign Up Successfull"),
          ),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${e.code.toString()}"),
          ),
        );
        log(
          e.code.toString(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Page"),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _fullnameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Full Name",
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Email",
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Password",
              ),
              obscureText: true,
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _cPasswordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Confirm Password",
              ),
              obscureText: true,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                signUpAction();
              },
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Already have an account.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            GestureDetector(
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }));
              },
              child: const Text(
                "LogIn",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
