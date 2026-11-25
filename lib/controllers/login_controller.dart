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

  void _showSnackbar(String title, String message, {bool isError = true}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: JT.card,
      colorText: Colors.white,
      borderColor: isError ? Colors.redAccent : JT.gold,
      borderWidth: 1.5,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      icon: Icon(
        isError ? Icons.error_outline : Icons.check_circle_outline,
        color: isError ? Colors.redAccent : JT.gold,
      ),
    );
  }

  void onForgot() {
    final email = emailController.text.trim();
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      _showSnackbar(
        'Email Required',
        'Pehle apna mukammal email address likhein (e.g. name@gmail.com)',
      );
      return;
    }
    _showSnackbar(
      'Password Reset',
      'Password reset link aap ke email ($email) par bhej diya gaya hai.',
      isError: false,
    );
  }

  void onSubmit() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // 1. Sign Up Full Name Validation
    if (!isLoginTab.value) {
      if (name.isEmpty) {
        _showSnackbar('Name Required', 'Meharbani karke apna poora naam likhein');
        return;
      }
      if (name.length < 3) {
        _showSnackbar('Invalid Name', 'Naam kam az kam 3 letters ka hona chahiye');
        return;
      }
    }

    // 2. Email Validation
    if (email.isEmpty) {
      _showSnackbar('Email Required', 'Meharbani karke apna email address likhein');
      return;
    }
    if (!GetUtils.isEmail(email)) {
      _showSnackbar(
        'Invalid Email Format',
        'Mukammal email address darj karein (e.g. example@gmail.com)',
      );
      return;
    }

    // 3. Password Validation
    if (password.isEmpty) {
      _showSnackbar('Password Required', 'Meharbani karke password likhein');
      return;
    }
    if (password.length < 6) {
      _showSnackbar(
        'Short Password',
        'Password kam az kam 6 characters ka hona chahiye',
      );
      return;
    }

    // Success Notification & Navigation
    _showSnackbar(
      isLoginTab.value ? 'Welcome Back!' : 'Account Created!',
      isLoginTab.value
          ? 'Shukriya! Login kamyab raha.'
          : 'Aap ka account kamyabi se ban gaya hai.',
      isError: false,
    );

    Get.to(
      () => GenderSelectionScreen(),
      transition: Transition.rightToLeftWithFade,
    );
  }

  void onGoogle() {
    _showSnackbar(
      'Google Login',
      'Google account se sign in kiya ja raha hai...',
      isError: false,
    );
    Get.to(
      () => GenderSelectionScreen(),
      transition: Transition.rightToLeftWithFade,
    );
  }

  void onApple() {
    _showSnackbar(
      'Apple Login',
      'Apple ID se sign in kiya ja raha hai...',
      isError: false,
    );
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
