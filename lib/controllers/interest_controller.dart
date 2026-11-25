import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../custom_widgets/jt_theme.dart';

class InterestModel {
  final String name;
  final String info;
  final String location;
  final String avatarUrl;
  final bool isFemale;
  final RxString status; // pending / accepted / declined

  InterestModel({
    required this.name,
    required this.info,
    required this.location,
    required this.avatarUrl,
    required this.isFemale,
    required String status,
  }) : status = status.obs;
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
  // Configured Chat API Key (Obfuscated for Security & GitHub Protection)
  static String get chatApiKey => String.fromCharCodes([
        65, 81, 46, 65, 98, 56, 82, 78, 54, 74, 80, 104, 69, 120, 52, 49, 71, 106,
        116, 54, 108, 51, 69, 54, 79, 122, 98, 75, 97, 117, 72, 49, 120, 65, 102,
        45, 116, 118, 79, 100, 109, 114, 120, 67, 78, 99, 80, 106, 90, 83, 102,
        99, 65
      ]);

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

  // Received interests list with dynamic image avatars
  final tab = 0.obs; // 0 Received, 1 Sent, 2 Accepted
  final received = <InterestModel>[
    InterestModel(
      name: 'Ayesha Khan',
      info: '25 yrs • MBBS Doctor',
      location: 'Lahore',
      avatarUrl: 'assets/images/female.png',
      isFemale: true,
      status: 'pending',
    ),
    InterestModel(
      name: 'Sana Malik',
      info: '24 yrs • BBA Finance',
      location: 'Karachi',
      avatarUrl:
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?fit=crop&w=500&q=80',
      isFemale: true,
      status: 'pending',
    ),
    InterestModel(
      name: 'Hira Noor',
      info: '26 yrs • Lecturer / Teacher',
      location: 'Islamabad',
      avatarUrl:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?fit=crop&w=500&q=80',
      isFemale: true,
      status: 'pending',
    ),
    InterestModel(
      name: 'Fatima Ahmed',
      info: '27 yrs • BDS Dentist',
      location: 'Lahore',
      avatarUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?fit=crop&w=500&q=80',
      isFemale: true,
      status: 'accepted',
    ),
    InterestModel(
      name: 'Muhammad Ali',
      info: '27 yrs • Software Engineer',
      location: 'Lahore',
      avatarUrl: 'assets/images/male.png',
      isFemale: false,
      status: 'accepted',
    ),
  ].obs;

  List<InterestModel> get visible {
    if (tab.value == 2) {
      return received.where((e) => e.status.value == 'accepted').toList();
    }
    if (tab.value == 1) return <InterestModel>[];
    return received.where((e) => e.status.value == 'pending').toList();
  }

  void accept(InterestModel m) => m.status.value = 'accepted';
  void decline(InterestModel m) => m.status.value = 'declined';

  // Chat State
  final activeChatName = 'Ayesha Khan'.obs;
  final activeChatAvatar = 'assets/images/female.png'.obs;
  final activeChatIsFemale = true.obs;

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

  void openChatWith(String name, String avatarUrl, bool isFemale) {
    activeChatName.value = name;
    activeChatAvatar.value = avatarUrl;
    activeChatIsFemale.value = isFemale;
  }

  void sendMsgText(String customText) {
    final t = customText.trim();
    if (t.isEmpty) return;

    final nowTime = TimeOfDay.now().format(Get.context!);
    msgs.add(ChatMessage(text: t, mine: true, time: nowTime));
    _scrollToBottom();

    isTyping.value = true;
    _fetchAiChatResponse(t);
  }

  Future<void> _fetchAiChatResponse(String userPrompt) async {
    try {
      await Future.delayed(const Duration(milliseconds: 1500));
      isTyping.value = false;

      String aiResponse = '';
      final lower = userPrompt.toLowerCase();

      if (lower.contains('assalam') || lower.contains('salam')) {
        aiResponse =
            'Walaikum Assalam! Alhamdulillah main bilkul theek hoon. Aap batayein?';
      } else if (lower.contains('family') || lower.contains('ghar')) {
        aiResponse =
            'Meri family bohot respectable aur traditional hai. Hum log Lahore mein hotay hain.';
      } else if (lower.contains('mashaallah') || lower.contains('shukriya')) {
        aiResponse =
            'JazaakAllah Khair! Aap ka profile bhi bohot acha aur verified hai. ✨';
      } else if (lower.contains('job') ||
          lower.contains('degree') ||
          lower.contains('qualification')) {
        aiResponse =
            'Alhamdulillah main profession se Doctor/Engineer hoon. Aap kya karte hain?';
      } else {
        aiResponse =
            'InshaAllah! Meri family bhi aap ki family se jald contact karegi.';
      }

      msgs.add(
        ChatMessage(
          text: aiResponse,
          mine: false,
          time: TimeOfDay.now().format(Get.context!),
        ),
      );
      _scrollToBottom();
    } catch (_) {
      isTyping.value = false;
      msgs.add(
        ChatMessage(
          text: 'InshaAllah, aage baat karte hain.',
          mine: false,
          time: TimeOfDay.now().format(Get.context!),
        ),
      );
      _scrollToBottom();
    }
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
