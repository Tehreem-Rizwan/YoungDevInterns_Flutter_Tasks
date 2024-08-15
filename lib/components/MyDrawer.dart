import 'package:e_library/Controller/BookController.dart';
import 'package:e_library/Pages/Homepage/HomePage.dart';
import 'package:e_library/Pages/ProfilePage/UserProfileScreen..dart';
import 'package:e_library/admin/admindashboard.dart';
import 'package:e_library/user/login_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Drawer myDrawer(BuildContext context, String role) {
  final BookController bookController = Get.find<BookController>();

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Text(
            'E-Library',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        if (role == 'Admin') ...[
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Admin Dashboard'),
            onTap: () {
              Get.to(() => AdminDashboard());
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () {
              Get.to(() => ProfilePage(
                    role: 'Admin',
                  ));
            },
          ),
          SizedBox(
            height: 470,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut().then((_) {
                Get.to(() => UserLoginScreen());
              });
            },
          ),
        ] else if (role == 'User') ...[
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Get.to(() => HomePage());
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () {
              Get.to(() => ProfilePage(role: "User"));
            },
          ),
          SizedBox(
            height: 470,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut().then((_) {
                print('User signed out');
                Get.to(() => UserLoginScreen());
              }).catchError((error) {
                print('Sign-out failed: $error');
              });
            },
          ),
        ],
      ],
    ),
  );
}
