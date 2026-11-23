import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  // Dots ka controller. 1 matlab beech wala dot active.
  final pageController = PageController(initialPage: 1);

  void onBack() {
    Get.back();
  }

  void onSkip() {
    // TODO: Get.offAllNamed('/login');
  }

  void onNext() {
    // TODO: Get.toNamed('/next-screen');
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}