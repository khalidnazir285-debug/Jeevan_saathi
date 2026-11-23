import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'jt_theme.dart';

class Country {
  final String name;
  final String flag;
  final String dialCode;
  final String code;

  const Country({
    required this.name,
    required this.flag,
    required this.dialCode,
    required this.code,
  });
}

class JtCountries {
  static const List<Country> list = [
    Country(name: 'Pakistan', flag: '🇵🇰', dialCode: '+92', code: 'PK'),
    Country(name: 'Saudi Arabia', flag: '🇸🇦', dialCode: '+966', code: 'SA'),
    Country(name: 'United Arab Emirates', flag: '🇦🇪', dialCode: '+971', code: 'AE'),
    Country(name: 'United Kingdom', flag: '🇬🇧', dialCode: '+44', code: 'GB'),
    Country(name: 'United States', flag: '🇺🇸', dialCode: '+1', code: 'US'),
    Country(name: 'Canada', flag: '🇨🇦', dialCode: '+1', code: 'CA'),
    Country(name: 'Qatar', flag: '🇶🇦', dialCode: '+974', code: 'QA'),
    Country(name: 'Kuwait', flag: '🇰🇼', dialCode: '+965', code: 'KW'),
    Country(name: 'Oman', flag: '🇴🇲', dialCode: '+968', code: 'OM'),
    Country(name: 'Bahrain', flag: '🇧🇭', dialCode: '+973', code: 'BH'),
    Country(name: 'Turkey', flag: '🇹🇷', dialCode: '+90', code: 'TR'),
    Country(name: 'Malaysia', flag: '🇲🇾', dialCode: '+60', code: 'MY'),
    Country(name: 'Indonesia', flag: '🇮🇩', dialCode: '+62', code: 'ID'),
    Country(name: 'Australia', flag: '🇦🇺', dialCode: '+61', code: 'AU'),
    Country(name: 'Germany', flag: '🇩🇪', dialCode: '+49', code: 'DE'),
    Country(name: 'France', flag: '🇫🇷', dialCode: '+33', code: 'FR'),
    Country(name: 'India', flag: '🇮🇳', dialCode: '+91', code: 'IN'),
    Country(name: 'Bangladesh', flag: '🇧🇩', dialCode: '+880', code: 'BD'),
    Country(name: 'South Africa', flag: '🇿🇦', dialCode: '+27', code: 'ZA'),
  ];
}

class JtCountryTile extends StatelessWidget {
  final String label;
  final RxString selectedCountry;
  final ValueChanged<Country>? onCountryChanged;

  const JtCountryTile({
    super.key,
    required this.label,
    required this.selectedCountry,
    this.onCountryChanged,
  });

  void _openCountryPicker() {
    final search = ''.obs;
    final searchCtrl = TextEditingController();

    Get.bottomSheet(
      Container(
        height: Get.height * 0.75,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          color: JT.card,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: JT.gold.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Text(
                'Select $label',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              // Search Input
              Container(
                decoration: BoxDecoration(
                  color: JT.bg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: JT.cardBorder),
                ),
                child: TextField(
                  controller: searchCtrl,
                  onChanged: (v) => search.value = v,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: 'Search country or code...',
                    hintStyle: TextStyle(color: JT.muted, fontSize: 13),
                    prefixIcon: Icon(Icons.search, color: JT.gold, size: 20),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // List of Countries
              Expanded(
                child: Obx(() {
                  final q = search.value.toLowerCase().trim();
                  final filtered = JtCountries.list.where((c) {
                    return c.name.toLowerCase().contains(q) ||
                        c.dialCode.contains(q) ||
                        c.code.toLowerCase().contains(q);
                  }).toList();

                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) =>
                        const Divider(color: JT.cardBorder, height: 1),
                    itemBuilder: (_, i) {
                      final c = filtered[i];
                      final isSel = selectedCountry.value.contains(c.name);

                      return ListTile(
                        leading: Text(c.flag, style: const TextStyle(fontSize: 26)),
                        title: Text(
                          c.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              c.dialCode,
                              style: const TextStyle(
                                color: JT.gold,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            if (isSel) ...[
                              const SizedBox(width: 8),
                              const Icon(Icons.check_circle, color: JT.gold, size: 18),
                            ],
                          ],
                        ),
                        onTap: () {
                          selectedCountry.value = c.name;
                          if (onCountryChanged != null) onCountryChanged!(c);
                          Get.back();
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: _openCountryPicker,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: JT.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: JT.cardBorder),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: JT.gold.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.public, color: JT.gold, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: const TextStyle(color: JT.muted, fontSize: 11)),
                    const SizedBox(height: 2),
                    Obx(() {
                      final name = selectedCountry.value;
                      final matched = JtCountries.list.firstWhere(
                        (element) => element.name == name,
                        orElse: () => JtCountries.list.first,
                      );
                      return Row(
                        children: [
                          Text(matched.flag, style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: JT.muted),
            ],
          ),
        ),
      ),
    );
  }
}

class JtPhoneTextField extends StatelessWidget {
  final RxString selectedDialCode;
  final RxString selectedFlag;
  final RxString phoneNumber;

  const JtPhoneTextField({
    super.key,
    required this.selectedDialCode,
    required this.selectedFlag,
    required this.phoneNumber,
  });

  void _openDialCodePicker() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.6,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          color: JT.card,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: JT.gold.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const Text(
                'Select Country Dial Code',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: JtCountries.list.length,
                  separatorBuilder: (_, __) =>
                      const Divider(color: JT.cardBorder, height: 1),
                  itemBuilder: (_, i) {
                    final c = JtCountries.list[i];
                    return ListTile(
                      leading: Text(c.flag, style: const TextStyle(fontSize: 24)),
                      title: Text(
                        c.name,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      trailing: Text(
                        c.dialCode,
                        style: const TextStyle(
                          color: JT.gold,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      onTap: () {
                        selectedDialCode.value = c.dialCode;
                        selectedFlag.value = c.flag;
                        Get.back();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: JT.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: JT.cardBorder),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: _openDialCodePicker,
              child: Obx(
                () => Row(
                  children: [
                    Text(selectedFlag.value, style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 4),
                    Text(
                      selectedDialCode.value,
                      style: const TextStyle(
                        color: JT.gold,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down, color: JT.muted),
                  ],
                ),
              ),
            ),
            const ContainerVerticalDivider(),
            Expanded(
              child: TextFormField(
                initialValue: phoneNumber.value,
                onChanged: (v) => phoneNumber.value = v,
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                decoration: const InputDecoration(
                  hintText: 'Enter phone number',
                  hintStyle: TextStyle(color: JT.muted, fontSize: 13),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerVerticalDivider extends StatelessWidget {
  const ContainerVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 24,
      width: 1,
      color: JT.cardBorder,
    );
  }
}
