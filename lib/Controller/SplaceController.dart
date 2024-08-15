import 'package:e_library/Pages/Homepage/HomePage.dart';
import 'package:e_library/components/RoleSelectionPage.dart';
import 'package:e_library/user/login_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplaceController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    splaceController();
  }

  void splaceController() {
    Future.delayed(Duration(seconds: 4), () {
      User? user = auth.currentUser;
      if (user != null) {
        // User is logged in, navigate to HomePage
        Get.offAll(() => HomePage());
      } else {
        // User is not logged in, navigate to login screen
        Get.offAll(() => UserLoginScreen());
      }
    });
  }
}
