import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../custom_widgets/jt_widgets.dart';
import 'family_details_screen.dart';

class EducationProfessionScreen extends StatelessWidget {
  EducationProfessionScreen({super.key});

  final c = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return JtScaffold(
      title: 'EDUCATION & PROFESSION',
      buttonText: 'Next',
      onPressed: () => Get.to(
        () => FamilyDetailsScreen(),
        transition: Transition.rightToLeftWithFade,
      ),
      children: [
        JtSelectTile(
          icon: Icons.school_outlined,
          label: 'Education Level',
          value: c.eduLevel,
          options: const [
            'Matric',
            'Intermediate',
            "Bachelor's Degree",
            "Master's Degree",
            'PhD',
          ],
        ),
        JtSelectTile(
          icon: Icons.menu_book_outlined,
          label: 'Degree',
          value: c.degree,
          options: const [
            'BS Computer Science',
            'BBA',
            'MBBS',
            'BS Software Engineering',
          ],
        ),
        JtSelectTile(
          icon: Icons.account_balance_outlined,
          label: 'Institution',
          value: c.institution,
          options: const ['PU Lahore', 'LUMS', 'NUST', 'FAST'],
        ),
        JtSelectTile(
          icon: Icons.work_outline,
          label: 'Profession',
          value: c.profession,
          options: const ['Software Engineer', 'Doctor', 'Teacher', 'Business'],
        ),
        JtSelectTile(
          icon: Icons.badge_outlined,
          label: 'Job Title',
          value: c.jobTitle,
          options: const ['Developer', 'Manager', 'Designer', 'Analyst'],
        ),
        JtSelectTile(
          icon: Icons.business,
          label: 'Company',
          value: c.company,
          options: const ['Google', 'Systems Ltd', 'Netsol', 'Self Employed'],
        ),
        JtSelectTile(
          icon: Icons.payments_outlined,
          label: 'Monthly Income',
          value: c.income,
          options: const ['< \$1k', '\$1k - \$2k', '\$2k - \$5k', '\$5k+'],
        ),
        JtSelectTile(
          icon: Icons.trending_up,
          label: 'Career Goals',
          value: c.goals,
          options: const ['Grow in Tech', 'Start Business', 'Higher Studies'],
        ),
      ],
    );
  }
}
