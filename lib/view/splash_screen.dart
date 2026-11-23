import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/splash_controller.dart';
import '../custom_widgets/app_colors.dart';
import '../custom_widgets/cutom_widgets.dart';
import '../custom_widgets/jt_theme.dart';
import '../custom_widgets/jt_widgets.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final c = Get.put(SplashController());

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
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Outer gold frame animation
                  FadeSlide(
                    dy: 0,
                    duration: const Duration(milliseconds: 800),
                    child: Container(
                      margin: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        border: Border.all(color: gold.withValues(alpha: 0.35)),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(160),
                          bottom: Radius.circular(28),
                        ),
                      ),
                    ),
                  ),

                  // Center content
                  Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const FadeSlide(
                            index: 0,
                            child: Icon(Icons.nightlight_round, color: gold, size: 42),
                          ),
                          const SizedBox(height: 24),

                          // Heart logo pulse animation
                          FadeSlide(
                            index: 1,
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.8, end: 1.0),
                              duration: const Duration(milliseconds: 1200),
                              curve: Curves.elasticOut,
                              builder: (_, scale, widget) => Transform.scale(
                                scale: scale,
                                child: widget,
                              ),
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: gold.withValues(alpha: 0.25),
                                      blurRadius: 40,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.favorite_border,
                                  color: gold,
                                  size: 76,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),
                          FadeSlide(
                            index: 2,
                            child: Text(
                              'Jeevan Saathi',
                              style: GoogleFonts.playfairDisplay(
                                color: gold,
                                fontSize: 38,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          FadeSlide(
                            index: 3,
                            child: Text(
                              'A BEAUTIFUL JOURNEY\nTOWARDS NIKAH',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.cinzel(
                                color: creamText,
                                fontSize: 12,
                                letterSpacing: 3,
                                height: 1.6,
                              ),
                            ),
                          ),
                          const SizedBox(height: 36),
                          const FadeSlide(
                            index: 4,
                            child: SizedBox(
                              width: 26,
                              height: 26,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: gold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom mosque
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 34,
                    child: FadeSlide(
                      dy: 30,
                      index: 5,
                      child: const Center(child: GoldMosque(size: 110)),
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
