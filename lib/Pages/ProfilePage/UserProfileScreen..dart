import 'package:e_library/components/RoleSelectionPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  final String role;

  const ProfilePage({Key? key, required this.role}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Choose image source'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
            child: Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
            child: Text('Gallery'),
          ),
        ],
      ),
    );
  }

  void _saveProfile() {
    // Save the profile picture to Firebase Storage or locally
    // Update the user's profile with the selected image
    // You can implement the logic here to upload the image to Firebase Storage
    // and update the user's profile photo URL in Firebase Authentication.
    Navigator.pop(context); // Close the edit screen after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.role == 'Admin' ? 'Admin Profile' : 'User Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Get.to(() => EditProfilePage(
                    imageFile: _imageFile,
                    onImageSelected: (image) {
                      setState(() {
                        _imageFile = image;
                      });
                    },
                  ));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  _imageFile != null ? FileImage(_imageFile!) : null,
              child: _imageFile == null ? Icon(Icons.person, size: 50) : null,
            ),
            SizedBox(height: 20),
            Text(
              user?.email ?? 'No Email',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                Get.to(() => RoleSelectionPage());
              },
              child: Text(
                'Select Role',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfilePage extends StatelessWidget {
  final File? imageFile;
  final Function(File) onImageSelected;

  const EditProfilePage({
    Key? key,
    required this.imageFile,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile Picture'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Save the selected image
              _saveProfile();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
              child: imageFile == null ? Icon(Icons.person, size: 50) : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showImageSourceDialog();
              },
              child: Text('Change Profile Picture'),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageSourceDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Choose image source'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(Get.context!);
              _pickImage(ImageSource.camera);
            },
            child: Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(Get.context!);
              _pickImage(ImageSource.gallery);
            },
            child: Text('Gallery'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      onImageSelected(File(pickedFile.path));
    }
  }

  void _saveProfile() {
    // Save the profile picture to Firebase Storage or locally
    Navigator.pop(Get.context!);
  }
}
