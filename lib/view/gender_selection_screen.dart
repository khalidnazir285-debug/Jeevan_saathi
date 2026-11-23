import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../custom_widgets/jt_theme.dart';
import '../custom_widgets/jt_widgets.dart';
import 'create_profile_screen.dart';

class GenderSelectionScreen extends StatelessWidget {
  GenderSelectionScreen({super.key});

  final c = Get.put(ProfileController());

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
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    FadeSlide(
                      child: Column(
                        children: const [
                          Text("Let's Get",
                              style: TextStyle(
                                  fontFamily: 'serif',
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white)),
                          Text('to Know You',
                              style: TextStyle(
                                  fontFamily: 'serif',
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                  color: JT.gold)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: FadeSlide(
                              index: 1,
                              child: _GenderCard(label: 'Male', icon: Icons.man, c: c)),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: FadeSlide(
                              index: 2,
                              child: _GenderCard(label: 'Female', icon: Icons.woman, c: c)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const FadeSlide(
                      index: 3,
                      child: Text(
                        'Select your gender to customize your matrimonial matches',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: JT.muted, fontSize: 12),
                      ),
                    ),
                    const Spacer(flex: 3),
                    FadeSlide(
                      index: 4,
                      child: JtGoldButton(
                        text: 'Continue',
                        onTap: () {
                          if (c.gender.value.isEmpty) {
                            Get.snackbar(
                              'Gender',
                              'Pehle gender select karein',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: JT.card,
                              colorText: Colors.white,
                              borderColor: JT.gold,
                              borderWidth: 1,
                              margin: const EdgeInsets.all(16),
                              borderRadius: 12,
                            );
                            return;
                          }
                          Get.to(() => CreateProfileScreen(),
                              transition: Transition.rightToLeftWithFade);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GenderCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final ProfileController c;
  const _GenderCard({required this.label, required this.icon, required this.c});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final sel = c.gender.value == label;
      return GestureDetector(
        onTap: () => c.selectGender(label),
        child: AnimatedScale(
          scale: sel ? 1.05 : 1,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutBack,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(vertical: 22),
            decoration: BoxDecoration(
              color: JT.card,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                  color: sel ? JT.gold : JT.cardBorder, width: sel ? 2 : 1),
              boxShadow: sel
                  ? [BoxShadow(color: JT.gold.withValues(alpha: 0.35), blurRadius: 18)]
                  : [],
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: JT.gold.withValues(alpha: 0.15),
                  child: Icon(icon, size: 42, color: JT.gold),
                ),
                const SizedBox(height: 12),
                Text(label,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    sel ? Icons.check_circle : Icons.circle_outlined,
                    key: ValueKey(sel),
                    color: sel ? JT.gold : JT.muted,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
