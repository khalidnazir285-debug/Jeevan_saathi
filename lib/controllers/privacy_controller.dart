import 'package:get/get.dart';

class PrivacyController extends GetxController {
  final profileVisibility = 'Everyone'.obs;
  final photoVisibility = 'Only Matches'.obs;
  final hidePhone = true.obs;
  final twoStep = true.obs;

  void deleteAccount() {
    Get.defaultDialog(
      title: 'Delete Account',
      middleText: 'Kya aap waqai apna account delete karna chahte hain?',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      onConfirm: () => Get.back(),
    );
  }
}
