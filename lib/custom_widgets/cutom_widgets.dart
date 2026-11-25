import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jeevan_saathi/custom_widgets/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// 1. Green background
class GreenBackground extends StatelessWidget {
  final Widget child;
  const GreenBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [greenTop, greenBottom],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: child,
          ),
        ),
      ),
    );
  }
}

// 2. Gol gold kinare wala icon button
class GoldCircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const GoldCircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: goldDark),
        ),
        child: Icon(icon, color: gold),
      ),
    );
  }
}

// 3. App Title
class AppTitle extends StatelessWidget {
  final String text;
  const AppTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_florist, color: gold, size: 16),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.cinzel(
              color: gold,
              fontSize: 14,
              letterSpacing: 2.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// 4. Skip button
class SkipButton extends StatelessWidget {
  final VoidCallback onTap;
  const SkipButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        'Skip',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// 5. Gold Circular Image Card with Continuous 360 Rotation Animation
class GoldImageCard extends StatefulWidget {
  final String imagePath;
  final String? tag;
  final bool showLine;

  const GoldImageCard({
    super.key,
    required this.imagePath,
    this.tag,
    this.showLine = true,
  });

  @override
  State<GoldImageCard> createState() => _GoldImageCardState();
}

class _GoldImageCardState extends State<GoldImageCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        // Continuously Rotating Circular Image Frame
        RotationTransition(
          turns: _rotationController,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: gold, width: 3),
              boxShadow: [
                BoxShadow(
                  color: gold.withValues(alpha: 0.30),
                  blurRadius: 28,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) {
                  return Container(
                    color: const Color(0xFF1B2A20),
                    child: const Center(
                      child: Icon(Icons.person, color: gold, size: 54),
                    ),
                  );
                },
              ),
            ),
          ),
        ),

        // Tag (e.g. FINAL STEP)
        if (widget.tag != null)
          Align(
            alignment: Alignment.topCenter,
            child: Transform.translate(
              offset: const Offset(0, -12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: greenTop,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: gold),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: gold,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.tag!,
                      style: GoogleFonts.poppins(
                        color: gold,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        // Moon badge on bottom right
        Positioned(
          right: 8,
          bottom: 8,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: greenTop,
              border: Border.all(color: gold, width: 1.5),
            ),
            child: const Icon(Icons.nightlight_round, color: gold, size: 18),
          ),
        ),
      ],
    );
  }
}

// 6. Heading
class HeadingText extends StatelessWidget {
  final String heading;
  final String highlight;
  const HeadingText({
    super.key,
    required this.heading,
    required this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.playfairDisplay(
          color: creamText,
          fontSize: 26,
          height: 1.25,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(text: heading),
          TextSpan(text: highlight, style: const TextStyle(color: gold)),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

// 7. Subtitle Text
class SubtitleText extends StatelessWidget {
  final String text;
  const SubtitleText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        color: Colors.white70,
        fontSize: 14,
        height: 1.5,
      ),
    );
  }
}

// 8. Dots
class PageDots extends StatelessWidget {
  final PageController controller;
  final int count;
  const PageDots({super.key, required this.controller, required this.count});

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: const ExpandingDotsEffect(
        dotWidth: 8,
        dotHeight: 8,
        expansionFactor: 3,
        spacing: 8,
        dotColor: Color(0xFF4A5A2E),
        activeDotColor: gold,
      ),
    );
  }
}

// 9. Gold gradient button
class GoldGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final IconData? icon;
  const GoldGradientButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [goldLight, gold, goldDark]),
        boxShadow: [
          BoxShadow(
            color: gold.withValues(alpha: 0.30),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: GoogleFonts.poppins(
                  color: darkText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 8),
                Icon(icon, color: darkText, size: 18),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// 10. Mosque Icon
class GoldMosque extends StatelessWidget {
  final double size;
  const GoldMosque({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [goldLight, goldDark],
        ).createShader(rect);
      },
      child: Icon(Icons.mosque, size: size, color: Colors.white),
    );
  }
}

// 11. Login / Sign Up Tab Switch
class GoldTabSwitch extends StatelessWidget {
  final List<String> tabs;
  final int selected;
  final ValueChanged<int> onChanged;
  const GoldTabSwitch({
    super.key,
    required this.tabs,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: goldDark.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final active = i == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: active
                      ? const LinearGradient(
                          colors: [goldLight, gold, goldDark],
                        )
                      : null,
                ),
                child: Text(
                  tabs[i],
                  style: GoogleFonts.poppins(
                    color: active ? darkText : Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// 12. Text field
class GoldTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool obscure;
  final Widget? suffix;
  final TextInputType? keyboardType;
  const GoldTextField({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.obscure = false,
    this.suffix,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: goldDark.withValues(alpha: 0.5)),
    );

    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      cursorColor: gold,
      style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(color: Colors.white54, fontSize: 14),
        prefixIcon: Icon(icon, color: goldDark),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.06),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        enabledBorder: border,
        border: border,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: gold, width: 1.5),
        ),
      ),
    );
  }
}

// 13. Or Divider
class OrDivider extends StatelessWidget {
  final String text;
  const OrDivider(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: goldDark.withValues(alpha: 0.4))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            text,
            style: GoogleFonts.poppins(color: Colors.white54, fontSize: 11),
          ),
        ),
        Expanded(child: Divider(color: goldDark.withValues(alpha: 0.4))),
      ],
    );
  }
}

// 14. Social Button
class SocialButton extends StatelessWidget {
  final FaIconData icon;
  final String text;
  final VoidCallback onTap;
  const SocialButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white.withValues(alpha: 0.04),
            border: Border.all(color: goldDark.withValues(alpha: 0.6)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 10),
              Text(
                text,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
