import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/interest_controller.dart';
import '../custom_widgets/jt_extra.dart';
import '../custom_widgets/jt_theme.dart';
import '../custom_widgets/jt_widgets.dart';

class SendInterestScreen extends StatelessWidget {
  SendInterestScreen({super.key});

  final c = Get.find<InterestController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JT.bg,
      body: Container(
        decoration: const BoxDecoration(gradient: JT.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              const JtHeader(title: 'Send Interest'),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const FadeSlide(
                      child: Center(child: JtAvatar(radius: 44)),
                    ),
                    const SizedBox(height: 10),
                    const FadeSlide(
                      index: 1,
                      child: Center(
                        child: Text('Ayesha Khan',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800)),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const FadeSlide(
                      index: 2,
                      child: Text('Quick Messages',
                          style: TextStyle(color: JT.gold, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(height: 8),
                    for (int i = 0; i < c.templates.length; i++)
                      FadeSlide(
                        index: i + 3,
                        child: Obx(() {
                          final sel = c.message.value == c.templates[i];
                          return GestureDetector(
                            onTap: () => c.message.value = c.templates[i],
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: JT.card,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                    color: sel ? JT.gold : JT.cardBorder,
                                    width: sel ? 2 : 1),
                                boxShadow: sel
                                    ? [BoxShadow(color: JT.gold.withOpacity(0.25), blurRadius: 12)]
                                    : [],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(c.templates[i],
                                          style: const TextStyle(color: Colors.white))),
                                  Icon(sel ? Icons.check_circle : Icons.circle_outlined,
                                      color: sel ? JT.gold : JT.muted, size: 20),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: JtGoldButton(text: 'Send Interest', onTap: c.sendInterest),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
