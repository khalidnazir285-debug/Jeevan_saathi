import 'package:get/get.dart';
import '../view/onboarding_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      if (Get.context != null) {
        Get.off(
          () => OnboardingScreen(),
          transition: Transition.fadeIn,
        );
      }
    });
  }
}
