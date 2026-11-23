import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../custom_widgets/jt_country_picker.dart';
import '../custom_widgets/jt_widgets.dart';
import 'education_profession_screen.dart';

class PersonalInformationScreen extends StatelessWidget {
  PersonalInformationScreen({super.key});

  final c = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return JtScaffold(
      title: 'Personal Information',
      buttonText: 'Next',
      onPressed: () => Get.to(
        () => EducationProfessionScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      children: [
        JtSelectTile(
          icon: Icons.star_border,
          label: 'AGE',
          value: c.age,
          options: List.generate(30, (i) => '${21 + i}'),
        ),
        JtSelectTile(
          icon: Icons.height,
          label: 'HEIGHT',
          value: c.height,
          options: const ['5\'4"', '5\'6"', '5\'8"', '5\'10"', '6\'0"'],
        ),
        JtSelectTile(
          icon: Icons.favorite_border,
          label: 'MARITAL STATUS',
          value: c.maritalStatus,
          options: const ['Never Married', 'Divorced', 'Widowed'],
        ),
        JtSelectTile(
          icon: Icons.translate,
          label: 'LANGUAGES',
          value: c.languages,
          options: const ['Urdu, English', 'Urdu', 'Punjabi, Urdu', 'English'],
        ),
        JtSelectTile(
          icon: Icons.brightness_3_outlined,
          label: 'RELIGION',
          value: c.religion,
          options: const ['Islam'],
        ),
        JtSelectTile(
          icon: Icons.apartment,
          label: 'CITY',
          value: c.city,
          options: const ['Lahore', 'Karachi', 'Islamabad', 'Okara', 'Rawalpindi'],
        ),
        JtCountryTile(
          label: 'COUNTRY',
          selectedCountry: c.country,
        ),
        JtSelectTile(
          icon: Icons.self_improvement,
          label: 'LIFESTYLE',
          value: c.lifestyle,
          options: const ['Moderate', 'Religious', 'Modern'],
        ),
      ],
    );
  }
}
