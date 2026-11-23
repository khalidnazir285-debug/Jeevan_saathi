import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../custom_widgets/jt_theme.dart';
import '../view/gender_selection_screen.dart';

class LoginController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoginTab = true.obs; // true = Login, false = Sign Up
  final rememberMe = true.obs;
  final hidePassword = true.obs;

  void setTab(int index) => isLoginTab.value = index == 0;

  void toggleRemember(bool? value) => rememberMe.value = value ?? false;

  void togglePassword() => hidePassword.value = !hidePassword.value;

  void onForgot() {
    Get.snackbar(
      'Forgot Password',
      'Password reset link has been sent to your email.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: JT.card,
      colorText: Colors.white,
      borderColor: JT.gold,
      borderWidth: 1,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void onSubmit() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Required',
        'Please enter email and password',
        snackPosition: SnackPosition.TOP,
        backgroundColor: JT.card,
        colorText: Colors.white,
        borderColor: JT.gold,
        borderWidth: 1,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    Get.to(
      () => GenderSelectionScreen(),
      transition: Transition.rightToLeftWithFade,
    );
  }

  void onGoogle() {
    Get.to(
      () => GenderSelectionScreen(),
      transition: Transition.rightToLeftWithFade,
    );
  }

  void onApple() {
    Get.to(
      () => GenderSelectionScreen(),
      transition: Transition.rightToLeftWithFade,
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
