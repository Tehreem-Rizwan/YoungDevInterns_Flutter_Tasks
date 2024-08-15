import 'package:e_library/user/login_user.dart';
import 'package:flutter/material.dart';

class RoleSelectionPage extends StatefulWidget {
  @override
  _RoleSelectionPageState createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  String selectedRole = 'Visitor'; // Default role selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Role Selection',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedRole,
              items: <String>['Visitor', 'Admin'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 18), // Increase font size
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedRole = newValue!;
                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20), // Adjust horizontal padding
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0), // Adjust border width
                  borderRadius:
                      BorderRadius.circular(10), // Adjust border radius
                ),
              ),
              dropdownColor:
                  Colors.white, // Background color of the dropdown menu
              itemHeight: 70, // Height of each item
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Navigate based on selected role
                if (selectedRole == 'Visitor') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserLoginScreen(),
                    ),
                  );
                } else if (selectedRole == 'Admin') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserLoginScreen(),
                    ),
                  );
                }
              },
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
