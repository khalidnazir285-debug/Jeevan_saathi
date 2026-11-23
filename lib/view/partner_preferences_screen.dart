import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../custom_widgets/jt_widgets.dart';

class PartnerPreferencesScreen extends StatelessWidget {
  PartnerPreferencesScreen({super.key});

  final c = Get.put(ProfileController());

  static String _ft(double inches) {
    final i = inches.round();
    return '${i ~/ 12}\'${i % 12}"';
  }

  @override
  Widget build(BuildContext context) {
    return JtScaffold(
      title: 'Partner Preferences',
      buttonText: 'Find Matches',
      onPressed: c.findMatches,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Text(
              'What Are You Looking For?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        JtRangeCard(
          label: 'Age Range',
          range: c.ageRange,
          min: 18,
          max: 50,
          display: (r) => '${r.start.round()} - ${r.end.round()}',
        ),
        JtRangeCard(
          label: 'Height Range',
          range: c.heightRange,
          min: 55,
          max: 80,
          display: (r) => '${_ft(r.start)} - ${_ft(r.end)}',
        ),
        JtSelectTile(
          icon: Icons.school_outlined,
          label: 'Education',
          value: c.prefEdu,
          options: const [
            'Any',
            'Intermediate or Above',
            "Bachelor's or Above",
            "Master's or Above",
          ],
        ),
        JtSelectTile(
          icon: Icons.work_outline,
          label: 'Profession',
          value: c.prefProfession,
          options: const [
            'Any',
            'Software Engineer',
            'Doctor',
            'Teacher',
            'Business',
          ],
        ),
        JtSelectTile(
          icon: Icons.location_city,
          label: 'City',
          value: c.prefCity,
          options: const ['Lahore', 'Karachi', 'Islamabad', 'Okara', 'Any'],
        ),
      ],
    );
  }
}
