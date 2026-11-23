import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../custom_widgets/jt_theme.dart';

class InterestModel {
  final String name;
  final String info;
  final RxString status; // pending / accepted / declined
  InterestModel(this.name, this.info, String s) : status = s.obs;
}

class ChatMessage {
  final String text;
  final bool mine;
  final String time;
  final bool isAudio;
  final bool isImage;

  ChatMessage({
    required this.text,
    required this.mine,
    required this.time,
    this.isAudio = false,
    this.isImage = false,
  });
}

class InterestController extends GetxController {
  // Send interest
  final message = 'Assalam o Alaikum, aap ka profile pasand aaya.'.obs;
  final sent = false.obs;
  final templates = const [
    'Assalam o Alaikum, aap ka profile pasand aaya.',
    'Kya hum aage baat kar sakte hain?',
    'Meri family aap ke family se milna chahegi.',
  ];

  void sendInterest() {
    sent.value = true;
    Get.snackbar(
      'Interest Sent',
      'Aap ka interest bhej diya gaya hai',
      snackPosition: SnackPosition.TOP,
      backgroundColor: JT.card,
      colorText: Colors.white,
      borderColor: JT.gold,
      borderWidth: 1,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  // Received interests
  final tab = 0.obs; // 0 Received, 1 Sent, 2 Accepted
  final received = <InterestModel>[
    InterestModel('Ayesha Khan', '25 yrs • Lahore • MBBS', 'pending'),
    InterestModel('Sana Malik', '24 yrs • Karachi • BBA', 'pending'),
    InterestModel('Hira Noor', '26 yrs • Islamabad • Teacher', 'pending'),
  ].obs;

  List<InterestModel> get visible {
    if (tab.value == 2) return received.where((e) => e.status.value == 'accepted').toList();
    if (tab.value == 1) return <InterestModel>[];
    return received.where((e) => e.status.value == 'pending').toList();
  }

  void accept(InterestModel m) => m.status.value = 'accepted';
  void decline(InterestModel m) => m.status.value = 'declined';

  // Chat
  final isTyping = false.obs;
  final chatScrollController = ScrollController();

  final msgs = <ChatMessage>[
    ChatMessage(
      text: 'Assalam o Alaikum! Kaise hain aap?',
      mine: false,
      time: '10:01 AM',
    ),
    ChatMessage(
      text: 'Walaikum Assalam, Alhamdulillah main bilkul theek hoon.',
      mine: true,
      time: '10:02 AM',
    ),
    ChatMessage(
      text: 'Aap ka profile bohot acha laga. Aap ki qualification kya hai?',
      mine: false,
      time: '10:03 AM',
    ),
    ChatMessage(
      text: 'Shukriya! Main ne BS Software Engineering ki hai PU se.',
      mine: true,
      time: '10:04 AM',
    ),
  ].obs;

  final input = TextEditingController();

  final quickSuggestions = const [
    'MashaAllah 🌸',
    'Family se kab milna hai?',
    'Aap ki hobbies kya hain?',
    'InshaAllah',
  ];

  void sendMsgText(String customText) {
    final t = customText.trim();
    if (t.isEmpty) return;

    final nowTime = TimeOfDay.now().format(Get.context!);
    msgs.add(ChatMessage(text: t, mine: true, time: nowTime));
    _scrollToBottom();

    // Simulated Auto Reply
    isTyping.value = true;
    Future.delayed(const Duration(milliseconds: 1800), () {
      isTyping.value = false;
      msgs.add(
        ChatMessage(
          text: 'JazaakAllah! InshaAllah meri family bhi jald baat karegi.',
          mine: false,
          time: TimeOfDay.now().format(Get.context!),
        ),
      );
      _scrollToBottom();
    });
  }

  void sendMsg() {
    final t = input.text.trim();
    if (t.isEmpty) return;
    sendMsgText(t);
    input.clear();
  }

  void sendAudioMsg() {
    final nowTime = TimeOfDay.now().format(Get.context!);
    msgs.add(
      ChatMessage(
        text: 'Voice Message (0:15)',
        mine: true,
        time: nowTime,
        isAudio: true,
      ),
    );
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (chatScrollController.hasClients) {
        chatScrollController.animateTo(
          chatScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // Notifications
  final notifTab = 0.obs; // 0 All, 1 Interests, 2 Messages
  final notifs = const [
    ['Ayesha Khan ne aap ko interest bheja', 'Interests', '2m'],
    ['Naya message: Alhamdulillah, aap ka...', 'Messages', '10m'],
    ['Aap ka profile 12 logon ne dekha', 'All', '1h'],
    ['Sana Malik ne interest accept kiya', 'Interests', '3h'],
  ];

  List<List<String>> get visibleNotifs {
    final t = ['All', 'Interests', 'Messages'][notifTab.value];
    return notifs
        .where((n) => t == 'All' || n[1] == t)
        .map((e) => List<String>.from(e))
        .toList();
  }

  @override
  void onClose() {
    input.dispose();
    chatScrollController.dispose();
    super.onClose();
  }
}
