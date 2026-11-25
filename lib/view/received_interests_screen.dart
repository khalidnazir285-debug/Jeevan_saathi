import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/interest_controller.dart';
import '../custom_widgets/jt_extra.dart';
import '../custom_widgets/jt_theme.dart';
import '../custom_widgets/jt_widgets.dart';
import 'chat_screen.dart';
import 'profile_details_screen.dart';

class ReceivedInterestsScreen extends StatelessWidget {
  ReceivedInterestsScreen({super.key});

  final c = Get.put(InterestController());

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
                  const JtHeader(title: 'Received Interests', trailing: Icons.tune),
                  Obx(
                    () => JtTabs(
                      tabs: const ['Received', 'Sent', 'Accepted'],
                      selected: c.tab.value,
                      onChanged: (i) => c.tab.value = i,
                    ),
                  ),
                  Expanded(
                    child: Obx(() {
                      final list = c.visible;
                      if (list.isEmpty) {
                        return const Center(
                          child: Text(
                            'Koi interest nahi hai',
                            style: TextStyle(color: JT.muted),
                          ),
                        );
                      }
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: list.length,
                        itemBuilder: (_, i) {
                          final m = list[i];
                          return FadeSlide(
                            index: i,
                            child: JtCard(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () => Get.to(
                                      () => ProfileDetailsScreen(
                                        name: m.name,
                                        info: m.info,
                                        location: m.location,
                                        avatarUrl: m.avatarUrl,
                                        isFemale: m.isFemale,
                                      ),
                                      transition: Transition.rightToLeftWithFade,
                                    ),
                                    child: Row(
                                      children: [
                                        JtAvatar(
                                          radius: 26,
                                          imageUrl: m.avatarUrl,
                                          isFemale: m.isFemale,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    m.name,
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
                                                m.info,
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
                                                    m.location,
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
                                  ),
                                  const SizedBox(height: 12),
                                  if (m.status.value == 'pending')
                                    Row(
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(color: JT.gold),
                                              foregroundColor: JT.gold,
                                            ),
                                            onPressed: () => c.decline(m),
                                            child: const Text('Decline'),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: JtGoldButton(
                                            text: 'Accept',
                                            onTap: () => c.accept(m),
                                          ),
                                        ),
                                      ],
                                    )
                                  else
                                    JtGoldButton(
                                      text: 'Chat',
                                      onTap: () {
                                        c.openChatWith(
                                          m.name,
                                          m.avatarUrl,
                                          m.isFemale,
                                        );
                                        Get.to(
                                          () => ChatScreen(),
                                          transition: Transition.rightToLeftWithFade,
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
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
