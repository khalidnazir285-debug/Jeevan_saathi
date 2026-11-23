import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../custom_widgets/jt_widgets.dart';
import 'partner_preferences_screen.dart';

class FamilyDetailsScreen extends StatelessWidget {
  FamilyDetailsScreen({super.key});

  final c = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return JtScaffold(
      title: 'FAMILY DETAILS',
      buttonText: 'Next',
      onPressed: () => Get.to(
        () => PartnerPreferencesScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      children: [
        JtSelectTile(
          icon: Icons.home_outlined,
          label: "Father's Occupation",
          value: c.fatherOcc,
          options: const ['Businessman', 'Govt Employee', 'Retired', 'Farmer'],
        ),
        JtSelectTile(
          icon: Icons.apartment,
          label: "Mother's Occupation",
          value: c.motherOcc,
          options: const ['Housewife', 'Teacher', 'Doctor', 'Retired'],
        ),
        JtSelectTile(
          icon: Icons.groups_outlined,
          label: 'Number of Siblings',
          value: c.siblings,
          options: const ['0', '1', '2', '3', '4', '5+'],
        ),
        JtSelectTile(
          icon: Icons.shield_outlined,
          label: 'Family Background',
          value: c.familyBg,
          options: const ['Respectable', 'Upper Middle', 'Middle Class'],
        ),
        JtSelectTile(
          icon: Icons.mosque_outlined,
          label: 'Family Values',
          value: c.familyValues,
          options: const ['Traditional', 'Moderate', 'Liberal'],
        ),
        JtSelectTile(
          icon: Icons.favorite_border,
          label: 'Family Involvement',
          value: c.familyInvolvement,
          options: const ['Preferable', 'Essential', 'Not Required'],
        ),
      ],
    );
  }
}
