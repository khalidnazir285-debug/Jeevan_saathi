import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeevan_saathi/view/login_screen.dart';

// Ek page ka data
class OnboardingItem {
  final String image;
  final String heading; // cream hissa
  final String highlight; // gold hissa
  final String subtitle;
  final String? tag; // jaise 'FINAL STEP'

  const OnboardingItem({
    required this.image,
    required this.heading,
    required this.highlight,
    required this.subtitle,
    this.tag,
  });
}

class OnboardingController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;

  // ---------- PAGES (text / image yahan badlein) ----------
  final List<OnboardingItem> items = const [
    OnboardingItem(
      image: 'assets/images/54451.png',
      heading: 'Find Your\nPerfect ',
      highlight: 'Life Partner',
      subtitle: 'Start a blessed journey together for Nikah.',
    ),
    OnboardingItem(
      image: 'assets/images/54452.png',
      heading: 'Meaningful\nConnections,\n',
      highlight: 'Genuine Intentions',
      subtitle: 'Find compatible matches\nfor a happy married life.',
    ),
    OnboardingItem(
      image: 'assets/images/54453.png',
      heading: 'YOUR JOURNEY\n',
      highlight: 'TOWARDS NIKAH\nSTARTS HERE',
      subtitle: 'With trust, respect and family support.',
      tag: 'FINAL STEP',
    ),
  ];

  bool get isLast => currentPage.value == items.length - 1;

  void onPageChanged(int index) => currentPage.value = index;

  void onNext() {
    if (isLast) {
      goToLogin();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void onBack() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void onSkip() => goToLogin();

  void goToLogin() {
    Get.offAll(() => LoginScreen());
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}