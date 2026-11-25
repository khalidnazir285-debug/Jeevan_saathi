import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../custom_widgets/jt_extra.dart';
import '../custom_widgets/jt_theme.dart';
import '../custom_widgets/jt_widgets.dart';
import 'create_profile_screen.dart';
import 'education_profession_screen.dart';
import 'family_details_screen.dart';
import 'login_screen.dart';
import 'partner_preferences_screen.dart';
import 'personal_information_screen.dart';
import 'privacy_security_screen.dart';

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen({super.key});

  final c = Get.put(ProfileController());

  void _confirmLogout() {
    Get.defaultDialog(
      title: 'Logout',
      titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      middleText: 'Kya aap waqai account se logout karna chahte hain?',
      middleTextStyle: const TextStyle(color: JT.muted, fontSize: 13),
      backgroundColor: JT.card,
      radius: 16,
      textConfirm: 'Logout',
      textCancel: 'Cancel',
      confirmTextColor: const Color(0xFF1B2A20),
      cancelTextColor: JT.gold,
      buttonColor: JT.gold,
      onConfirm: () {
        Get.back();
        Get.offAll(
          () => LoginScreen(),
          transition: Transition.fadeIn,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JT.bg,
      body: Container(
        decoration: const BoxDecoration(gradient: JT.bgGradient),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                children: [
                  JtHeader(
                    title: 'My Profile',
                    trailing: Icons.logout,
                    onTrailing: _confirmLogout,
                  ),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      children: [
                        // User Avatar & Main Info
                        FadeSlide(
                          index: 0,
                          child: Column(
                            children: [
                              Obx(
                                () => JtAvatar(
                                  radius: 50,
                                  imagePath: c.userAvatar.value,
                                  imageUrl: c.gender.value == 'Female'
                                      ? 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?fit=crop&w=500&q=80'
                                      : 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?fit=crop&w=500&q=80',
                                  isFemale: c.gender.value == 'Female',
                                  heroTag: 'user_my_profile_avatar',
                                ),
                              ),
                              const SizedBox(height: 10),
                              Obx(
                                () => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      c.fullName.value,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Icon(
                                      Icons.verified,
                                      color: JT.gold,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Obx(
                                () => Text(
                                  '${c.gender.value} • ${c.city.value}, ${c.country.value}',
                                  style: const TextStyle(
                                    color: JT.muted,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),
                            ],
                          ),
                        ),

                        // Profile Completion Card
                        FadeSlide(
                          index: 1,
                          child: JtCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Profile Strength',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      '70% Complete',
                                      style: TextStyle(
                                        color: JT.gold,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0, end: 0.7),
                                  duration: const Duration(milliseconds: 700),
                                  curve: Curves.easeOut,
                                  builder: (_, v, _) => ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: v,
                                      minHeight: 6,
                                      backgroundColor: Colors.white12,
                                      valueColor: const AlwaysStoppedAnimation(
                                        JT.gold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Section 1: Basic Information
                        FadeSlide(
                          index: 2,
                          child: _profileTile(
                            icon: Icons.person_outline,
                            title: 'Basic Info & Location',
                            subtitle: 'Name, DOB, Gender, Phone & Country',
                            onTap: () => Get.to(
                              () => CreateProfileScreen(),
                              transition: Transition.rightToLeftWithFade,
                            ),
                          ),
                        ),

                        // Section 2: Personal Information
                        FadeSlide(
                          index: 3,
                          child: _profileTile(
                            icon: Icons.info_outline,
                            title: 'Personal Information',
                            subtitle: 'Age, Height, Marital Status, Religion',
                            onTap: () => Get.to(
                              () => PersonalInformationScreen(),
                              transition: Transition.rightToLeftWithFade,
                            ),
                          ),
                        ),

                        // Section 3: Education & Profession
                        FadeSlide(
                          index: 4,
                          child: _profileTile(
                            icon: Icons.school_outlined,
                            title: 'Education & Profession',
                            subtitle: 'Degree, Profession, Company, Income',
                            onTap: () => Get.to(
                              () => EducationProfessionScreen(),
                              transition: Transition.rightToLeftWithFade,
                            ),
                          ),
                        ),

                        // Section 4: Family Details
                        FadeSlide(
                          index: 5,
                          child: _profileTile(
                            icon: Icons.home_outlined,
                            title: 'Family Details',
                            subtitle: 'Parents, Siblings, Background & Values',
                            onTap: () => Get.to(
                              () => FamilyDetailsScreen(),
                              transition: Transition.rightToLeftWithFade,
                            ),
                          ),
                        ),

                        // Section 5: Partner Preferences
                        FadeSlide(
                          index: 6,
                          child: _profileTile(
                            icon: Icons.favorite_border,
                            title: 'Partner Preferences',
                            subtitle: 'Age Range, Height, Location Preferences',
                            onTap: () => Get.to(
                              () => PartnerPreferencesScreen(),
                              transition: Transition.rightToLeftWithFade,
                            ),
                          ),
                        ),

                        // Section 6: Privacy & Security
                        FadeSlide(
                          index: 7,
                          child: _profileTile(
                            icon: Icons.security,
                            title: 'Privacy & Security',
                            subtitle: 'Visibility, Blocked users, Password',
                            onTap: () => Get.to(
                              () => PrivacySecurityScreen(),
                              transition: Transition.rightToLeftWithFade,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Logout Tile
                        FadeSlide(
                          index: 8,
                          child: InkWell(
                            onTap: _confirmLogout,
                            borderRadius: BorderRadius.circular(14),
                            child: JtCard(
                              child: Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: Colors.redAccent.withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.logout,
                                      color: Colors.redAccent,
                                      size: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Expanded(
                                    child: Text(
                                      'Log Out Account',
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: JT.muted,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: JtCard(
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: JT.gold.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: JT.gold, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: JT.muted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: JT.muted),
          ],
        ),
      ),
    );
  }
}
