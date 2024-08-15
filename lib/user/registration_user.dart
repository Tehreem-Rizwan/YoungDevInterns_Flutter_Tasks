import 'package:e_library/Pages/Homepage/HomePage.dart';
import 'package:e_library/components/UIHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_library/components/my_textfield.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({super.key});

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Add a variable to store the selected role
  String selectedRole = 'User';

  // List of roles
  final List<String> roles = ['User', 'Admin'];

  void checkValues() {
    String fullName = fullNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (fullName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        selectedRole.isEmpty) {
      UIHelper.showAlertDialog(
          context, "Incomplete Data", "Please fill all the fields");
    } else if (password != confirmPassword) {
      UIHelper.showAlertDialog(context, "Password Mismatch",
          "The password and confirm password do not match");
    } else {
      signUp(fullName, email, password, selectedRole);
    }
  }

  void signUp(
      String fullName, String email, String password, String role) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print("User registered with UID: ${userCredential.user!.uid}");

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'fullName': fullName,
        'email': email,
        'uid': uid,
        'role': role, // Store the selected role in Firestore
      });
      print("User data stored in Firestore");

      // Registration successful, navigate to HomePage
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ),
      );
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
      UIHelper.showAlertDialog(context, "Sign Up Failed", e.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 100, 211, 150),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Icon(Icons.menu_book, size: 100),
                  SizedBox(height: 50),
                  const Text(
                    "Create a new account",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 50),
                  MyTextfield(
                    controller: fullNameController,
                    hintText: "Full Name",
                    obscureText: false,
                  ),
                  SizedBox(height: 10),
                  MyTextfield(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                  ),
                  SizedBox(height: 10),
                  MyTextfield(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  MyTextfield(
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  // Role selection dropdown
                  DropdownButton<String>(
                    value: selectedRole,
                    items: roles.map((String role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                    onChanged: (String? newRole) {
                      setState(() {
                        selectedRole = newRole!;
                      });
                    },
                    isExpanded: true,
                    hint: Text('Select Role'),
                  ),
                  const SizedBox(height: 30),
                  CupertinoButton(
                    onPressed: checkValues,
                    color: Colors.black,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Log In",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
