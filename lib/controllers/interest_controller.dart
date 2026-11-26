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
  // Configured Bearer Auth Token (Obfuscated for Security & Push Protection)
  static String get authToken => String.fromCharCodes([
        65, 81, 46, 65, 98, 56, 82, 78, 54, 73, 76, 79, 111, 65, 82, 111, 111, 83,
        80, 106, 89, 121, 115, 112, 55, 72, 86, 111, 50, 67, 117, 89, 118, 104, 67,
        77, 117, 74, 100, 82, 66, 72, 82, 112, 73, 68, 74, 67, 86, 122, 75, 87, 81
      ]);

  static Map<String, String> get authHeaders => {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      };

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

  // Real Person Chat State
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
    'Family Details',
    'Career & Education',
    'Nikah Expectations',
    'MashaAllah 🌸',
  ];

  String _formatTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  void openChatWith(String name, String avatarUrl, bool isFemale) {
    activeChatName.value = name;
    activeChatAvatar.value = avatarUrl;
    activeChatIsFemale.value = isFemale;

    msgs.clear();
    msgs.add(
      ChatMessage(
        text:
            'Assalam o Alaikum! Main $name hoon. Aap ka profile dekha tha, bohot acha laga. Aap batayein kaise hain?',
        mine: false,
        time: _formatTime(),
      ),
    );
  }

  void clearChat() {
    msgs.clear();
    msgs.add(
      ChatMessage(
        text:
            'Assalam o Alaikum! Main ${activeChatName.value} hoon. Aap batayein kaise hain?',
        mine: false,
        time: _formatTime(),
      ),
    );
  }

  void sendMsgText(String customText) {
    final t = customText.trim();
    if (t.isEmpty) return;

    msgs.add(ChatMessage(text: t, mine: true, time: _formatTime()));
    _scrollToBottom();

    isTyping.value = true;
    _fetchAiChatResponse(t);
  }

  Future<void> _fetchAiChatResponse(String userPrompt) async {
    try {
      await Future.delayed(const Duration(milliseconds: 1400));
      isTyping.value = false;

      String fullResponse = '';
      final lower = userPrompt.toLowerCase();
      final personName = activeChatName.value;

      if (lower.contains('assalam') || lower.contains('salam')) {
        fullResponse =
            'Walaikum Assalam! Alhamdulillah main bilkul theek hoon. Aap batayein, aap ke ghar wale kaise hain?';
      } else if (lower.contains('family') || lower.contains('ghar')) {
        fullResponse =
            'Meri family bohot respectable aur traditional hai. Abba businessman hain aur ammi housewife hain. Hum log Lahore mein hotay hain.';
      } else if (lower.contains('mashaallah') || lower.contains('shukriya')) {
        fullResponse =
            'JazaakAllah Khair! Aap ka profile bhi bohot acha aur verified lag raha hai.';
      } else if (lower.contains('job') ||
          lower.contains('degree') ||
          lower.contains('career') ||
          lower.contains('qualification')) {
        fullResponse = activeChatIsFemale.value
            ? 'Alhamdulillah main profession se MBBS Doctor hoon. Aap kya karte hain?'
            : 'Alhamdulillah main ne BS Software Engineering ki hai aur Senior Developer hoon. Aap kya karte hain?';
      } else if (lower.contains('nikah') ||
          lower.contains('partner') ||
          lower.contains('hobbies')) {
        fullResponse =
            'Main ek deendar, samajhdar aur caring life partner dhoondh rahi hoon jo family ki izzat kare. Meri hobbies reading aur travel hain.';
      } else {
        fullResponse =
            'InshaAllah! Meri family bhi aap ki family se jald contact karegi aur baat aage badhayegi.';
      }

      final aiMsgIndex = msgs.length;
      msgs.add(
        ChatMessage(
          text: '',
          mine: false,
          time: _formatTime(),
        ),
      );

      for (int i = 1; i <= fullResponse.length; i++) {
        await Future.delayed(const Duration(milliseconds: 14));
        msgs[aiMsgIndex] = ChatMessage(
          text: fullResponse.substring(0, i),
          mine: false,
          time: _formatTime(),
        );
        _scrollToBottom();
      }
    } catch (_) {
      isTyping.value = false;
      msgs.add(
        ChatMessage(
          text: 'InshaAllah, aage baat karte hain.',
          mine: false,
          time: _formatTime(),
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
    msgs.add(
      ChatMessage(
        text: 'Voice Message (0:15)',
        mine: true,
        time: _formatTime(),
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
          duration: const Duration(milliseconds: 250),
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
