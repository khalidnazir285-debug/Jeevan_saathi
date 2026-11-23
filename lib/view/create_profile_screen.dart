import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../custom_widgets/jt_country_picker.dart';
import '../custom_widgets/jt_theme.dart';
import '../custom_widgets/jt_widgets.dart';
import 'personal_information_screen.dart';

class CreateProfileScreen extends StatelessWidget {
  CreateProfileScreen({super.key});

  final c = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return JtScaffold(
      title: 'Create Profile',
      buttonText: 'Next',
      onPressed: () => Get.to(
        () => PersonalInformationScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      top: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Step 1 of 5', style: TextStyle(color: JT.gold, fontSize: 11)),
                Text('Profile Setup', style: TextStyle(color: JT.muted, fontSize: 11)),
              ],
            ),
            const SizedBox(height: 6),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 0.2),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOut,
              builder: (_, v, _) => ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: v,
                  minHeight: 4,
                  backgroundColor: Colors.white12,
                  valueColor: const AlwaysStoppedAnimation(JT.gold),
                ),
              ),
            ),
          ],
        ),
      ),
      children: [
        const SizedBox(height: 12),
        Center(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: JT.goldGradient,
                ),
                child: const CircleAvatar(
                  radius: 42,
                  backgroundColor: JT.card,
                  child: Icon(Icons.person, size: 46, color: JT.gold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: JT.gold,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.camera_alt, size: 14, color: Colors.black87),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Center(
          child: Text('70% Complete', style: TextStyle(color: JT.gold, fontSize: 11)),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: JT.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: JT.cardBorder),
          ),
          child: Row(
            children: const [
              Icon(Icons.lock_outline, color: JT.gold, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Blur Photo until Interest Accepted\nPrivacy First • Recommended',
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ],
          ),
        ),
        JtSelectTile(
          icon: Icons.person_outline,
          label: 'Full Name',
          value: c.fullName,
          options: const ['Muhammad Ali', 'Ahmed Khan', 'Ayesha Khan'],
        ),
        JtSelectTile(
          icon: Icons.cake_outlined,
          label: 'Date of Birth',
          value: c.dob,
          options: const ['01-01-1998', '15-05-1999', '20-09-2000'],
        ),
        JtSelectTile(
          icon: Icons.person_pin_outlined,
          label: 'Gender',
          value: c.gender,
          options: const ['Male', 'Female'],
        ),
        JtPhoneTextField(
          selectedDialCode: c.countryDialCode,
          selectedFlag: c.countryFlag,
          phoneNumber: c.phone,
        ),
        JtCountryTile(
          label: 'Country / Location',
          selectedCountry: c.country,
        ),
      ],
    );
  }
}
