import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class MatchModel {
  final String name;
  final String info;
  final String tag;
  final String avatarUrl;
  final bool isFemale;

  MatchModel({
    required this.name,
    required this.info,
    required this.tag,
    required this.avatarUrl,
    required this.isFemale,
  });
}

class HomeController extends GetxController {
  final navIndex = 0.obs;
  final filterIndex = 0.obs;
  final filters = const ['All', 'Lahore', 'Age 22-30', 'Engineers', 'Recent'];
  final profileComplete = 0.7; // 70%

  final searchQuery = ''.obs;
  final searchController = TextEditingController();

  // Female Matches (for Male users)
  final femaleMatches = <MatchModel>[
    MatchModel(
      name: 'Ayesha Khan',
      info: '25 yrs • MBBS Doctor',
      tag: 'Lahore',
      avatarUrl: 'assets/images/female.png',
      isFemale: true,
    ),
    MatchModel(
      name: 'Sana Malik',
      info: '24 yrs • BBA Finance',
      tag: 'Karachi',
      avatarUrl:
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?fit=crop&w=500&q=80',
      isFemale: true,
    ),
    MatchModel(
      name: 'Hira Noor',
      info: '26 yrs • Lecturer / Teacher',
      tag: 'Islamabad',
      avatarUrl:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?fit=crop&w=500&q=80',
      isFemale: true,
    ),
    MatchModel(
      name: 'Zainab Ali',
      info: '23 yrs • Software Engineer',
      tag: 'Lahore',
      avatarUrl:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?fit=crop&w=500&q=80',
      isFemale: true,
    ),
    MatchModel(
      name: 'Fatima Ahmed',
      info: '27 yrs • BDS Dentist',
      tag: 'Lahore',
      avatarUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?fit=crop&w=500&q=80',
      isFemale: true,
    ),
    MatchModel(
      name: 'Mariam Raza',
      info: '25 yrs • Graphic Designer',
      tag: 'Islamabad',
      avatarUrl:
          'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?fit=crop&w=500&q=80',
      isFemale: true,
    ),
  ];

  // Male Matches (for Female users)
  final maleMatches = <MatchModel>[
    MatchModel(
      name: 'Muhammad Ali',
      info: '27 yrs • Software Engineer',
      tag: 'Lahore',
      avatarUrl: 'assets/images/male.png',
      isFemale: false,
    ),
    MatchModel(
      name: 'Ahmed Raza',
      info: '28 yrs • MBBS Doctor',
      tag: 'Karachi',
      avatarUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?fit=crop&w=500&q=80',
      isFemale: false,
    ),
    MatchModel(
      name: 'Hamza Malik',
      info: '26 yrs • Business Owner',
      tag: 'Islamabad',
      avatarUrl:
          'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?fit=crop&w=500&q=80',
      isFemale: false,
    ),
    MatchModel(
      name: 'Usman Tariq',
      info: '29 yrs • Civil Engineer',
      tag: 'Lahore',
      avatarUrl:
          'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?fit=crop&w=500&q=80',
      isFemale: false,
    ),
    MatchModel(
      name: 'Bilal Chaudhry',
      info: '27 yrs • Senior Banker',
      tag: 'Lahore',
      avatarUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?fit=crop&w=500&q=80',
      isFemale: false,
    ),
    MatchModel(
      name: 'Zubair Khan',
      info: '28 yrs • University Lecturer',
      tag: 'Islamabad',
      avatarUrl:
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?fit=crop&w=500&q=80',
      isFemale: false,
    ),
  ];

  List<MatchModel> get visibleMatches {
    final profileCtrl = Get.put(ProfileController());
    final isUserMale = profileCtrl.gender.value == 'Male';

    final currentList = isUserMale ? femaleMatches : maleMatches;

    final f = filters[filterIndex.value];
    final q = searchQuery.value.toLowerCase().trim();

    return currentList.where((m) {
      bool matchesFilter = true;
      if (f == 'Lahore') matchesFilter = m.tag == 'Lahore';
      if (f == 'Engineers') {
        matchesFilter = m.info.toLowerCase().contains('computer') ||
            m.info.toLowerCase().contains('engineer') ||
            m.info.toLowerCase().contains('software');
      }

      bool matchesSearch = q.isEmpty ||
          m.name.toLowerCase().contains(q) ||
          m.info.toLowerCase().contains(q) ||
          m.tag.toLowerCase().contains(q);

      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
