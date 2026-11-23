import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'jt_theme.dart';

class FadeSlide extends StatelessWidget {
  final Widget child;
  final int index;
  final double dy;
  final double dx;
  final Duration? duration;
  final Curve curve;

  const FadeSlide({
    super.key,
    required this.child,
    this.index = 0,
    this.dy = 24,
    this.dx = 0,
    this.duration,
    this.curve = Curves.easeOutCubic,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration ?? Duration(milliseconds: 400 + index * 80),
      curve: curve,
      builder: (_, v, w) => Opacity(
        opacity: v,
        child: Transform.translate(
          offset: Offset((1 - v) * dx, (1 - v) * dy),
          child: w,
        ),
      ),
      child: child,
    );
  }
}

class JtScaffold extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final String buttonText;
  final VoidCallback onPressed;
  final bool showBack;
  final Widget? top;

  const JtScaffold({
    super.key,
    required this.title,
    required this.children,
    required this.buttonText,
    required this.onPressed,
    this.showBack = true,
    this.top,
  });

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
                  FadeSlide(
                    dy: -16,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Row(
                        children: [
                          showBack
                              ? _RoundIcon(icon: Icons.arrow_back_ios_new, onTap: Get.back)
                              : const SizedBox(width: 40),
                          Expanded(
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(title, style: JT.heading),
                              ),
                            ),
                          ),
                          const _RoundIcon(icon: Icons.menu_book_outlined),
                        ],
                      ),
                    ),
                  ),
                  if (top != null) top!,
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      itemCount: children.length,
                      itemBuilder: (_, i) => FadeSlide(index: i, child: children[i]),
                    ),
                  ),
                  FadeSlide(
                    index: children.length,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: JtGoldButton(text: buttonText, onTap: onPressed),
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

class _RoundIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _RoundIcon({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: JT.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: JT.cardBorder),
          ),
          child: Icon(icon, color: JT.gold, size: 16),
        ),
      ),
    );
  }
}

class JtGoldButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  const JtGoldButton({super.key, required this.text, required this.onTap});

  @override
  State<JtGoldButton> createState() => _JtGoldButtonState();
}

class _JtGoldButtonState extends State<JtGoldButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          height: 52,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: JT.goldGradient,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: JT.gold.withOpacity(0.35),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: const TextStyle(
                  color: Color(0xFF1B2A20),
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, size: 18, color: Color(0xFF1B2A20)),
            ],
          ),
        ),
      ),
    );
  }
}

class JtSelectTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final RxString value;
  final List<String> options;

  const JtSelectTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.options,
  });

  void _open() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          color: JT.card,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: JT.gold.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              for (final o in options)
                ListTile(
                  title: Text(o, style: const TextStyle(color: Colors.white)),
                  trailing: Obx(() => value.value == o
                      ? const Icon(Icons.check_circle, color: JT.gold)
                      : const SizedBox.shrink()),
                  onTap: () {
                    value.value = o;
                    Get.back();
                  },
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
      child: InkWell(
        onTap: _open,
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
                  color: JT.gold.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: JT.gold, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: const TextStyle(color: JT.muted, fontSize: 11)),
                    const SizedBox(height: 2),
                    Obx(() => AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: Text(
                            value.value,
                            key: ValueKey(value.value),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        )),
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

class JtRangeCard extends StatelessWidget {
  final String label;
  final Rx<RangeValues> range;
  final double min;
  final double max;
  final String Function(RangeValues) display;

  const JtRangeCard({
    super.key,
    required this.label,
    required this.range,
    required this.min,
    required this.max,
    required this.display,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 4),
      decoration: BoxDecoration(
        color: JT.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: JT.cardBorder),
      ),
      child: Obx(() => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    display(range.value),
                    style: const TextStyle(color: JT.gold, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: JT.gold,
                  inactiveTrackColor: Colors.white12,
                  thumbColor: JT.gold,
                  overlayColor: JT.gold.withOpacity(0.15),
                  trackHeight: 3,
                ),
                child: RangeSlider(
                  values: range.value,
                  min: min,
                  max: max,
                  onChanged: (v) => range.value = v,
                ),
              ),
            ],
          )),
    );
  }
}
