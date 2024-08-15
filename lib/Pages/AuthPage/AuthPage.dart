import 'package:e_library/Pages/AuthPage/AuthPageBody.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Welcome To E LIBRARY"),
                SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
