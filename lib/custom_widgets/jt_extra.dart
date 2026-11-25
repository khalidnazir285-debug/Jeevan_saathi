import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'jt_theme.dart';
import 'jt_widgets.dart';

class JtHeader extends StatelessWidget {
  final String title;
  final IconData? trailing;
  final VoidCallback? onTrailing;
  const JtHeader({super.key, required this.title, this.trailing, this.onTrailing});

  @override
  Widget build(BuildContext context) {
    return FadeSlide(
      dy: -16,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Row(
          children: [
            _circle(Icons.arrow_back_ios_new, Get.back),
            Expanded(
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(title, style: JT.heading),
                ),
              ),
            ),
            trailing == null
                ? const SizedBox(width: 40)
                : _circle(trailing!, onTrailing),
          ],
        ),
      ),
    );
  }

  Widget _circle(IconData i, VoidCallback? t) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: t,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: JT.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: JT.cardBorder),
            ),
            child: Icon(i, color: JT.gold, size: 16),
          ),
        ),
      );
}

class JtAvatar extends StatelessWidget {
  final double radius;
  final IconData icon;
  final String? imageUrl;
  final String? imagePath;
  final bool isFemale;

  const JtAvatar({
    super.key,
    this.radius = 30,
    this.icon = Icons.person,
    this.imageUrl,
    this.imagePath,
    this.isFemale = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget childWidget;

    if (imagePath != null && imagePath!.isNotEmpty) {
      childWidget = ClipOval(
        child: Image.asset(
          imagePath!,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) {
            if (imageUrl != null && imageUrl!.isNotEmpty) {
              return Image.network(
                imageUrl!,
                width: radius * 2,
                height: radius * 2,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _defaultIcon(),
              );
            }
            return _defaultIcon();
          },
        ),
      );
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      childWidget = ClipOval(
        child: Image.network(
          imageUrl!,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => _defaultIcon(),
        ),
      );
    } else {
      childWidget = _defaultIcon();
    }

    return Container(
      padding: const EdgeInsets.all(2.5),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: JT.goldGradient,
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: JT.card,
        child: childWidget,
      ),
    );
  }

  Widget _defaultIcon() {
    return Icon(
      isFemale ? Icons.woman : (icon == Icons.person ? Icons.man : icon),
      color: JT.gold,
      size: radius * 1.1,
    );
  }
}

class JtCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const JtCard({super.key, required this.child, this.padding = const EdgeInsets.all(14)});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: padding,
      decoration: BoxDecoration(
        color: JT.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: JT.cardBorder),
      ),
      child: child,
    );
  }
}

class JtTabs extends StatelessWidget {
  final List<String> tabs;
  final int selected;
  final ValueChanged<int> onChanged;
  const JtTabs({super.key, required this.tabs, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: JT.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: JT.cardBorder),
      ),
      child: Row(
        children: [
          for (int i = 0; i < tabs.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: i == selected ? JT.goldGradient : null,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    tabs[i],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: i == selected ? const Color(0xFF1B2A20) : JT.muted,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
