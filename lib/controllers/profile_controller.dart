import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/home_matches_screen.dart';

class ProfileController extends GetxController {
  // Gender ('Male' or 'Female')
  final gender = 'Male'.obs;

  // Create profile
  final fullName = 'Muhammad Ali'.obs;
  final dob = '01-01-1998'.obs;
  final phone = '300 1234567'.obs;
  final location = 'Lahore'.obs;
  final countryDialCode = '+92'.obs;
  final countryFlag = '🇵🇰'.obs;
  final userAvatar = 'assets/images/male.png'.obs;

  // Personal information
  final age = '27'.obs;
  final height = '5\'10"'.obs;
  final maritalStatus = 'Never Married'.obs;
  final languages = 'Urdu, English'.obs;
  final religion = 'Islam'.obs;
  final city = 'Lahore'.obs;
  final country = 'Pakistan'.obs;
  final lifestyle = 'Moderate'.obs;

  // Education & profession
  final eduLevel = "Bachelor's Degree".obs;
  final degree = 'BS Computer Science'.obs;
  final institution = 'PU Lahore'.obs;
  final profession = 'Software Engineer'.obs;
  final jobTitle = 'Developer'.obs;
  final company = 'Google'.obs;
  final income = '\$1k - \$2k'.obs;
  final goals = 'Grow in Tech'.obs;

  // Family details
  final fatherOcc = 'Businessman'.obs;
  final motherOcc = 'Housewife'.obs;
  final siblings = '2'.obs;
  final familyBg = 'Respectable'.obs;
  final familyValues = 'Traditional'.obs;
  final familyInvolvement = 'Preferable'.obs;

  // Partner preferences
  final ageRange = const RangeValues(22, 30).obs;
  final heightRange = const RangeValues(64, 70).obs;
  final prefEdu = "Bachelor's or Above".obs;
  final prefProfession = 'Any'.obs;
  final prefCity = 'Lahore'.obs;
  final prefCountry = 'Pakistan'.obs;

  void selectGender(String g) {
    gender.value = g;
    if (g == 'Male') {
      fullName.value = 'Muhammad Ali';
      userAvatar.value = 'assets/images/male.png';
    } else {
      fullName.value = 'Ayesha Khan';
      userAvatar.value = 'assets/images/female.png';
    }
  }

  void findMatches() {
    Get.offAll(
      () => HomeMatchesScreen(),
      transition: Transition.rightToLeftWithFade,
    );
  }
}
