import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/interest_controller.dart';
import '../custom_widgets/jt_extra.dart';
import '../custom_widgets/jt_theme.dart';
import '../custom_widgets/jt_widgets.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final c = Get.put(InterestController());

  void _showCallDialog(String title, IconData icon) {
    Get.dialog(
      Dialog(
        backgroundColor: JT.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: JT.gold.withValues(alpha: 0.15),
                ),
                child: Icon(icon, color: JT.gold, size: 36),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Text(
                  'Calling ${c.activeChatName.value}...',
                  style: const TextStyle(color: JT.muted, fontSize: 13),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.redAccent,
                    child: IconButton(
                      icon: const Icon(Icons.call_end, color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.green,
                    child: IconButton(
                      icon: const Icon(Icons.call, color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAttachmentModal(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: JT.card,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: JT.gold.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const Text(
                'Share Media & Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _attachOption(
                    Icons.camera_alt_outlined,
                    'Camera',
                    () => Get.back(),
                  ),
                  _attachOption(
                    Icons.photo_outlined,
                    'Gallery',
                    () => Get.back(),
                  ),
                  _attachOption(
                    Icons.mic_none_outlined,
                    'Audio Note',
                    () {
                      Get.back();
                      c.sendAudioMsg();
                    },
                  ),
                  _attachOption(
                    Icons.location_on_outlined,
                    'Location',
                    () => Get.back(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _attachOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: JT.gold.withValues(alpha: 0.15),
              border: Border.all(color: JT.cardBorder),
            ),
            child: Icon(icon, color: JT.gold, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: JT.muted, fontSize: 11)),
        ],
      ),
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
                  // App Bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: Get.back,
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: JT.gold,
                            size: 18,
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Obx(
                              () => JtAvatar(
                                radius: 20,
                                imageUrl: c.activeChatAvatar.value,
                                isFemale: c.activeChatIsFemale.value,
                              ),
                            ),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: const Color(0xFF4ADE80),
                                shape: BoxShape.circle,
                                border: Border.all(color: JT.card, width: 1.5),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Obx(
                                    () => Text(
                                      c.activeChatName.value,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.verified, color: JT.gold, size: 14),
                                ],
                              ),
                              Obx(
                                () => Text(
                                  c.isTyping.value ? 'typing...' : 'Online',
                                  style: TextStyle(
                                    color: c.isTyping.value
                                        ? JT.gold
                                        : const Color(0xFF4ADE80),
                                    fontSize: 11,
                                    fontStyle: c.isTyping.value
                                        ? FontStyle.italic
                                        : FontStyle.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.call, color: JT.gold, size: 20),
                          onPressed: () => _showCallDialog(
                            'Voice Call',
                            Icons.call,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.videocam,
                            color: JT.gold,
                            size: 22,
                          ),
                          onPressed: () => _showCallDialog(
                            'Video Call',
                            Icons.videocam,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: JT.cardBorder, height: 1),

                  // Chat Message List
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        controller: c.chatScrollController,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                        itemCount: c.msgs.length,
                        itemBuilder: (_, i) {
                          final m = c.msgs[i];
                          return FadeSlide(
                            index: i,
                            dy: 12,
                            child: Align(
                              alignment: m.mine
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.76,
                                ),
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  gradient: m.mine ? JT.goldGradient : null,
                                  color: m.mine ? null : JT.card,
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(16),
                                    topRight: const Radius.circular(16),
                                    bottomLeft: Radius.circular(m.mine ? 16 : 4),
                                    bottomRight: Radius.circular(m.mine ? 4 : 16),
                                  ),
                                  border: m.mine
                                      ? null
                                      : Border.all(color: JT.cardBorder),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (m.isAudio)
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.play_circle_fill,
                                            color: m.mine
                                                ? const Color(0xFF1B2A20)
                                                : JT.gold,
                                            size: 28,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Container(
                                              height: 4,
                                              decoration: BoxDecoration(
                                                color: m.mine
                                                    ? Colors.black26
                                                    : Colors.white24,
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            '0:15',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: m.mine
                                                  ? const Color(0xFF1B2A20)
                                                  : Colors.white70,
                                            ),
                                          ),
                                        ],
                                      )
                                    else
                                      Text(
                                        m.text,
                                        style: TextStyle(
                                          fontSize: 14,
                                          height: 1.35,
                                          color: m.mine
                                              ? const Color(0xFF1B2A20)
                                              : Colors.white,
                                          fontWeight: m.mine
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                        ),
                                      ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          m.time,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: m.mine
                                                ? Colors.black54
                                                : JT.muted,
                                          ),
                                        ),
                                        if (m.mine) ...[
                                          const SizedBox(width: 4),
                                          const Icon(
                                            Icons.done_all,
                                            size: 14,
                                            color: Color(0xFF1B2A20),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Quick Suggestion Chips
                  SizedBox(
                    height: 38,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: c.quickSuggestions.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (_, i) {
                        final tag = c.quickSuggestions[i];
                        return ActionChip(
                          backgroundColor: JT.card,
                          side: const BorderSide(color: JT.cardBorder),
                          label: Text(
                            tag,
                            style: const TextStyle(
                              color: JT.gold,
                              fontSize: 12,
                            ),
                          ),
                          onPressed: () => c.sendMsgText(tag),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Text Input Bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.add_circle_outline,
                            color: JT.gold,
                            size: 24,
                          ),
                          onPressed: () => _showAttachmentModal(context),
                        ),
                        Expanded(
                          child: TextField(
                            controller: c.input,
                            style: const TextStyle(color: Colors.white),
                            onSubmitted: (_) => c.sendMsg(),
                            decoration: InputDecoration(
                              hintText: 'Message likhein...',
                              hintStyle: const TextStyle(color: JT.muted),
                              filled: true,
                              fillColor: JT.card,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(color: JT.cardBorder),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(color: JT.cardBorder),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(color: JT.gold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: c.sendMsg,
                          child: Container(
                            width: 46,
                            height: 46,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: JT.goldGradient,
                            ),
                            child: const Icon(
                              Icons.send,
                              color: Color(0xFF1B2A20),
                              size: 20,
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
}
