import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/privacy_controller.dart';
import '../custom_widgets/jt_extra.dart';
import '../custom_widgets/jt_theme.dart';
import '../custom_widgets/jt_widgets.dart';

class PrivacySecurityScreen extends StatelessWidget {
  PrivacySecurityScreen({super.key});

  final c = Get.put(PrivacyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JT.bg,
      body: Container(
        decoration: const BoxDecoration(gradient: JT.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              const JtHeader(title: 'Privacy & Security'),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  children: [
                    FadeSlide(
                      index: 0,
                      child: JtSelectTile(
                        icon: Icons.visibility_outlined,
                        label: 'Profile Visibility',
                        value: c.profileVisibility,
                        options: const ['Everyone', 'Only Matches', 'Nobody'],
                      ),
                    ),
                    FadeSlide(
                      index: 1,
                      child: _switchTile(
                        Icons.phone_locked_outlined,
                        'Hide Phone Number',
                        c.hidePhone,
                      ),
                    ),
                    FadeSlide(
                      index: 2,
                      child: JtSelectTile(
                        icon: Icons.photo_outlined,
                        label: 'Photo Visibility',
                        value: c.photoVisibility,
                        options: const [
                          'Everyone',
                          'Only Matches',
                          'After Interest Accepted',
                        ],
                      ),
                    ),
                    FadeSlide(
                      index: 3,
                      child: _navTile(Icons.block, 'Blocked Users', () {}),
                    ),
                    FadeSlide(
                      index: 4,
                      child: _navTile(Icons.flag_outlined, 'Report User', () {}),
                    ),
                    FadeSlide(
                      index: 5,
                      child: _navTile(Icons.lock_outline, 'Change Password', () {}),
                    ),
                    FadeSlide(
                      index: 6,
                      child: _switchTile(
                        Icons.security,
                        'Two-Step Verification',
                        c.twoStep,
                      ),
                    ),
                    FadeSlide(
                      index: 7,
                      child: _navTile(
                        Icons.manage_accounts_outlined,
                        'Manage Account',
                        () {},
                      ),
                    ),
                    FadeSlide(
                      index: 8,
                      child: _navTile(
                        Icons.delete_outline,
                        'Delete Account',
                        c.deleteAccount,
                        danger: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _switchTile(IconData icon, String title, RxBool value) {
    return JtCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          _iconBox(icon),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
          Obx(() => Switch(
                value: value.value,
                onChanged: (v) => value.value = v,
                activeThumbColor: JT.gold,
                activeTrackColor: JT.gold.withValues(alpha: 0.35),
                inactiveTrackColor: Colors.white12,
              )),
        ],
      ),
    );
  }

  Widget _navTile(IconData icon, String title, VoidCallback onTap, {bool danger = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: JtCard(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            _iconBox(icon, danger: danger),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: danger ? Colors.redAccent : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: JT.muted),
          ],
        ),
      ),
    );
  }

  Widget _iconBox(IconData icon, {bool danger = false}) {
    final col = danger ? Colors.redAccent : JT.gold;
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: col.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: col, size: 18),
    );
  }
}
