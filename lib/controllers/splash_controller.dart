import 'package:get/get.dart';
import 'package:jeevan_saathi/view/onboarding_screen.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    // 3 second baad onboarding par
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => OnboardingScreen());
    });
  }
}