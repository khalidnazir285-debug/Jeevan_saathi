import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/interest_controller.dart';
import '../custom_widgets/jt_extra.dart';
import '../custom_widgets/jt_theme.dart';
import '../custom_widgets/jt_widgets.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final c = Get.put(InterestController());

  IconData _icon(String type) => type == 'Messages'
      ? Icons.chat_bubble_outline
      : (type == 'Interests' ? Icons.favorite_border : Icons.visibility_outlined);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JT.bg,
      body: Container(
        decoration: const BoxDecoration(gradient: JT.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              const JtHeader(title: 'Notifications', trailing: Icons.done_all),
              Obx(() => JtTabs(
                    tabs: const ['All', 'Interests', 'Messages'],
                    selected: c.notifTab.value,
                    onChanged: (i) => c.notifTab.value = i,
                  )),
              Expanded(
                child: Obx(() {
                  final list = c.visibleNotifs;
                  return ListView.builder(
                    key: ValueKey(c.notifTab.value),
                    padding: const EdgeInsets.all(16),
                    itemCount: list.length,
                    itemBuilder: (_, i) => FadeSlide(
                      index: i,
                      child: JtCard(
                        child: Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: JT.gold.withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(_icon(list[i][1]), color: JT.gold, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(list[i][0],
                                  style: const TextStyle(color: Colors.white, fontSize: 13)),
                            ),
                            const SizedBox(width: 8),
                            Text(list[i][2],
                                style: const TextStyle(color: JT.muted, fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
