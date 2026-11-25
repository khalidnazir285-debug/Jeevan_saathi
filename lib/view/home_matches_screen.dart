import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/interest_controller.dart';
import '../controllers/profile_controller.dart';
import '../custom_widgets/jt_extra.dart';
import '../custom_widgets/jt_theme.dart';
import '../custom_widgets/jt_widgets.dart';
import 'chat_screen.dart';
import 'my_profile_screen.dart';
import 'notifications_screen.dart';
import 'profile_details_screen.dart';
import 'received_interests_screen.dart';
import 'send_interest_screen.dart';

class HomeMatchesScreen extends StatelessWidget {
  HomeMatchesScreen({super.key});

  final c = Get.put(HomeController());
  final cProfile = Get.put(ProfileController());

  void _onNav(int i) {
    c.navIndex.value = i;
    if (i == 1) Get.to(() => ReceivedInterestsScreen());
    if (i == 2) Get.to(() => NotificationsScreen());
    if (i == 3) Get.to(() => ChatScreen());
    if (i == 4) Get.to(() => MyProfileScreen());
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
                  // Top bar with User Name & Avatar
                  FadeSlide(
                    dy: -16,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(() => MyProfileScreen()),
                            child: Obx(
                              () => JtAvatar(
                                radius: 20,
                                imageUrl: cProfile.userAvatar.value.isNotEmpty
                                    ? cProfile.userAvatar.value
                                    : null,
                                isFemale: cProfile.gender.value == 'Female',
                                heroTag: 'user_main_avatar',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Get.to(() => MyProfileScreen()),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Assalam o Alaikum',
                                    style: TextStyle(color: JT.muted, fontSize: 11),
                                  ),
                                  Obx(
                                    () => Text(
                                      cProfile.fullName.value,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Get.to(() => NotificationsScreen()),
                            icon: const Icon(Icons.notifications_none, color: JT.gold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      children: [
                        // Profile complete card
                        FadeSlide(
                          index: 1,
                          child: GestureDetector(
                            onTap: () => Get.to(() => MyProfileScreen()),
                            child: JtCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.verified_user_outlined,
                                        color: JT.gold,
                                        size: 18,
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Profile Complete',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '70%',
                                        style: TextStyle(
                                          color: JT.gold,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  TweenAnimationBuilder<double>(
                                    tween: Tween(begin: 0, end: c.profileComplete),
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.fastOutSlowIn,
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
                        ),

                        // Search Bar
                        FadeSlide(
                          index: 2,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: JT.card,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: JT.cardBorder),
                            ),
                            child: TextField(
                              controller: c.searchController,
                              onChanged: (val) => c.searchQuery.value = val,
                              style: const TextStyle(color: Colors.white, fontSize: 13),
                              decoration: InputDecoration(
                                hintText: 'Search for matches...',
                                hintStyle: const TextStyle(color: JT.muted, fontSize: 13),
                                prefixIcon: const Icon(Icons.search, color: JT.gold, size: 20),
                                suffixIcon: Obx(
                                  () => c.searchQuery.value.isNotEmpty
                                      ? IconButton(
                                          icon: const Icon(Icons.clear, color: JT.muted, size: 18),
                                          onPressed: () {
                                            c.searchController.clear();
                                            c.searchQuery.value = '';
                                          },
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Filter chips
                        FadeSlide(
                          index: 3,
                          child: SizedBox(
                            height: 36,
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: c.filters.length,
                              separatorBuilder: (_, _) => const SizedBox(width: 8),
                              itemBuilder: (_, i) => Obx(() {
                                final sel = c.filterIndex.value == i;
                                return GestureDetector(
                                  onTap: () => c.filterIndex.value = i,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    curve: Curves.fastOutSlowIn,
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: sel ? JT.goldGradient : null,
                                      color: sel ? null : JT.card,
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(color: sel ? JT.gold : JT.cardBorder),
                                    ),
                                    child: Text(
                                      c.filters[i],
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: sel ? const Color(0xFF1B2A20) : Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Title Bar
                        FadeSlide(
                          index: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => Text(
                                  cProfile.gender.value == 'Male'
                                      ? 'Recommended Bride Matches'
                                      : 'Recommended Groom Matches',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const Text('View All', style: TextStyle(color: JT.gold, fontSize: 12)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Match Cards based on Selected Gender
                        Obx(() {
                          final list = c.visibleMatches;
                          if (list.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 32),
                              child: Center(
                                child: Text(
                                  'No matches found for your search',
                                  style: TextStyle(color: JT.muted, fontSize: 13),
                                ),
                              ),
                            );
                          }
                          return Column(
                            key: ValueKey(
                              '${cProfile.gender.value}_${c.filterIndex.value}_${c.searchQuery.value}',
                            ),
                            children: [
                              for (int i = 0; i < list.length; i++)
                                FadeSlide(
                                  index: i,
                                  child: JtCard(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            JtAvatar(
                                              radius: 28,
                                              imageUrl: list[i].avatarUrl,
                                              isFemale: list[i].isFemale,
                                              heroTag: 'profile_avatar_${list[i].name}',
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        list[i].name,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w800,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      const Icon(
                                                        Icons.verified,
                                                        color: JT.gold,
                                                        size: 14,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 3),
                                                  Text(
                                                    list[i].info,
                                                    style: const TextStyle(
                                                      color: JT.muted,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 3),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.location_on,
                                                        color: JT.gold,
                                                        size: 12,
                                                      ),
                                                      const SizedBox(width: 3),
                                                      Text(
                                                        list[i].tag,
                                                        style: const TextStyle(
                                                          color: JT.muted,
                                                          fontSize: 11,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  side: const BorderSide(color: JT.gold),
                                                  foregroundColor: JT.gold,
                                                ),
                                                onPressed: () => Get.to(
                                                  () => ProfileDetailsScreen(
                                                    name: list[i].name,
                                                    info: list[i].info,
                                                    location: list[i].tag,
                                                    avatarUrl: list[i].avatarUrl,
                                                    isFemale: list[i].isFemale,
                                                  ),
                                                  transition: Transition.rightToLeftWithFade,
                                                ),
                                                child: const Text('View Profile'),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: JtGoldButton(
                                                text: 'Interest',
                                                onTap: () {
                                                  Get.put(InterestController());
                                                  Get.to(() => SendInterestScreen());
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),

                  // Bottom navigation
                  Obx(
                    () => Container(
                      decoration: const BoxDecoration(
                        color: JT.card,
                        border: Border(top: BorderSide(color: JT.cardBorder)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _navItem(Icons.home_outlined, 'Home', 0),
                          _navItem(Icons.favorite_border, 'Interests', 1),
                          _navItem(Icons.notifications_none, 'Alerts', 2),
                          _navItem(Icons.chat_bubble_outline, 'Chat', 3),
                          _navItem(Icons.person_outline, 'Profile', 4),
                        ],
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

  Widget _navItem(IconData icon, String label, int i) {
    final sel = c.navIndex.value == i;
    return GestureDetector(
      onTap: () => _onNav(i),
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: sel ? 1.12 : 1,
        duration: const Duration(milliseconds: 180),
        curve: Curves.fastOutSlowIn,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: sel ? JT.gold : JT.muted, size: 22),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: sel ? JT.gold : JT.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
