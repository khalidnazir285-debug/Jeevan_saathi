import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/interest_controller.dart';
import '../custom_widgets/jt_extra.dart';
import '../custom_widgets/jt_theme.dart';
import '../custom_widgets/jt_widgets.dart';
import 'send_interest_screen.dart';

class ProfileDetailsScreen extends StatelessWidget {
  final String name;
  final String info;
  final String location;
  final String avatarUrl;
  final bool isFemale;

  ProfileDetailsScreen({
    super.key,
    this.name = 'Ayesha Khan',
    this.info = '25 yrs • MBBS Doctor',
    this.location = 'Lahore',
    this.avatarUrl =
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?fit=crop&w=500&q=80',
    this.isFemale = true,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(InterestController());

    final rows = [
      [Icons.cake_outlined, 'Age', info.split('•').first.trim()],
      [Icons.height, 'Height', '5\'4"'],
      [Icons.favorite_border, 'Marital Status', 'Never Married'],
      [
        Icons.school_outlined,
        'Education / Profession',
        info.contains('•') ? info.split('•').last.trim() : info,
      ],
      [Icons.location_on_outlined, 'City', location],
      [Icons.groups_outlined, 'Family Background', 'Respectable, Traditional'],
    ];

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
                  const JtHeader(title: 'Profile Details', trailing: Icons.more_vert),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      children: [
                        FadeSlide(
                          child: Column(
                            children: [
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0.6, end: 1),
                                duration: const Duration(milliseconds: 700),
                                curve: Curves.elasticOut,
                                builder: (_, v, w) =>
                                    Transform.scale(scale: v, child: w),
                                child: JtAvatar(
                                  radius: 54,
                                  imageUrl: avatarUrl,
                                  isFemale: isFemale,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.verified,
                                    color: JT.gold,
                                    size: 20,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '100% Halal & Verified Profile',
                                style: TextStyle(color: JT.muted, fontSize: 12),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                        for (int i = 0; i < rows.length; i++)
                          FadeSlide(
                            index: i + 1,
                            child: JtCard(
                              child: Row(
                                children: [
                                  Icon(
                                    rows[i][0] as IconData,
                                    color: JT.gold,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      rows[i][1] as String,
                                      style: const TextStyle(
                                        color: JT.muted,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    rows[i][2] as String,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: JtGoldButton(
                      text: 'Send Interest',
                      onTap: () => Get.to(
                        () => SendInterestScreen(),
                        transition: Transition.rightToLeftWithFade,
                      ),
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
}
