import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/onboarding_controller.dart';
import '../custom_widgets/app_colors.dart';
import '../custom_widgets/cutom_widgets.dart';
import '../custom_widgets/jt_theme.dart';
import '../custom_widgets/jt_widgets.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final c = Get.put(OnboardingController());

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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    FadeSlide(dy: -16, child: topBar()),
                    Expanded(child: pages()),
                    FadeSlide(
                      index: 1,
                      child: PageDots(
                        controller: c.pageController,
                        count: c.items.length,
                      ),
                    ),
                    const SizedBox(height: 22),
                    FadeSlide(index: 2, child: nextButton()),
                    FadeSlide(index: 3, child: footnote()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------- 1. TOP BAR: back | naam | skip ----------
  Widget topBar() {
    return Row(
      children: [
        SizedBox(
          width: 64,
          child: Align(
            alignment: Alignment.centerLeft,
            child: GoldCircleIconButton(
              icon: Icons.chevron_left,
              onTap: c.onBack,
            ),
          ),
        ),
        const Expanded(child: Center(child: AppTitle('JEEVAN SAATHI'))),
        SizedBox(
          width: 64,
          child: Align(
            alignment: Alignment.centerRight,
            child: Obx(
              () => c.isLast
                  ? const SizedBox.shrink()
                  : SkipButton(onTap: c.onSkip),
            ),
          ),
        ),
      ],
    );
  }

  // ---------- 2. PAGES ----------
  Widget pages() {
    return PageView.builder(
      physics: const BouncingScrollPhysics(),
      controller: c.pageController,
      itemCount: c.items.length,
      onPageChanged: c.onPageChanged,
      itemBuilder: (context, index) {
        return pageContent(c.items[index]);
      },
    );
  }

  Widget pageContent(OnboardingItem item) {
    return LayoutBuilder(
      builder: (context, box) {
        final byHeight = math.min(math.max(box.maxHeight - 230, 140.0), 400.0);
        final imageSize = math.min(byHeight, box.maxWidth);

        return Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: Transform.rotate(
                      angle: 0.08,
                      child: RotatingImageCard(
                        imagePath: item.image,
                        tag: item.tag,
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  HeadingText(
                    heading: item.heading,
                    highlight: item.highlight,
                  ),
                  const SizedBox(height: 12),
                  SubtitleText(item.subtitle),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ---------- 4. NEXT BUTTON ----------
  Widget nextButton() {
    return Obx(
      () => GoldGradientButton(
        text: c.isLast ? 'Get Started' : 'Next',
        icon: Icons.arrow_forward,
        onTap: c.onNext,
      ),
    );
  }

  // ---------- 5. Footnote ----------
  Widget footnote() {
    return SizedBox(
      height: 46,
      child: Center(
        child: Obx(
          () => c.isLast
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.verified_user, color: gold, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      '100% Halal & Verified Community',
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}

class RotatingImageCard extends StatefulWidget {
  final String imagePath;
  final String? tag;

  const RotatingImageCard({
    super.key,
    required this.imagePath,
    this.tag,
  });

  @override
  State<RotatingImageCard> createState() => _RotatingImageCardState();
}

class _RotatingImageCardState extends State<RotatingImageCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    );
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: controller,
      child: GoldImageCard(
        imagePath: widget.imagePath,
        tag: widget.tag,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
