import 'package:get/get.dart';

class UserController extends GetxController {
  var userRole = ''.obs;

  void setUserRole(String role) {
    userRole.value = role;
  }
}
