import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';
import '../custom_widgets/app_colors.dart';
import '../custom_widgets/cutom_widgets.dart';
import '../custom_widgets/jt_theme.dart';
import '../custom_widgets/jt_widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final c = Get.put(LoginController());

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
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Opacity(opacity: 0.35, child: GoldMosque(size: 90)),
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(24, 30, 24, 40),
                    child: Column(
                      children: [
                        FadeSlide(dy: -20, child: logoPart()),
                        const SizedBox(height: 28),
                        FadeSlide(index: 1, child: formPart()),
                        const SizedBox(height: 20),
                        const FadeSlide(index: 2, child: OrDivider('or continue with')),
                        const SizedBox(height: 14),
                        FadeSlide(index: 3, child: socialPart()),
                        const SizedBox(height: 22),
                        FadeSlide(index: 4, child: bottomText()),
                      ],
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

  // ---------- 1. LOGO + NAAM ----------
  Widget logoPart() {
    return Column(
      children: [
        const Icon(Icons.favorite_border, color: gold, size: 54),
        const SizedBox(height: 10),
        Text(
          'JEEVAN SAATHI',
          style: GoogleFonts.cinzel(
            color: gold,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'A BEAUTIFUL JOURNEY TOWARDS NIKAH.',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: creamText,
            fontSize: 10,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  // ---------- 2. FORM: tab + fields + button ----------
  Widget formPart() {
    return Column(
      children: [
        Obx(
          () => GoldTabSwitch(
            tabs: const ['Login', 'Sign Up'],
            selected: c.isLoginTab.value ? 0 : 1,
            onChanged: c.setTab,
          ),
        ),
        const SizedBox(height: 18),
        Obx(
          () => c.isLoginTab.value
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: GoldTextField(
                    hint: 'Full Name',
                    icon: Icons.person_outline,
                    controller: c.nameController,
                  ),
                ),
        ),
        GoldTextField(
          hint: 'Email Address',
          icon: Icons.email_outlined,
          controller: c.emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 14),
        Obx(
          () => GoldTextField(
            hint: 'Password',
            icon: Icons.lock_outline,
            controller: c.passwordController,
            obscure: c.hidePassword.value,
            suffix: IconButton(
              onPressed: c.togglePassword,
              icon: Icon(
                c.hidePassword.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.white54,
                size: 20,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => c.isLoginTab.value
              ? Row(
                  children: [
                    Checkbox(
                      value: c.rememberMe.value,
                      onChanged: c.toggleRemember,
                      activeColor: gold,
                      checkColor: darkText,
                      side: const BorderSide(color: goldDark),
                    ),
                    Text(
                      'Remember Me',
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: c.onForgot,
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.poppins(
                          color: gold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox(height: 16),
        ),
        Obx(
          () => GoldGradientButton(
            text: c.isLoginTab.value ? 'Login' : 'Create Account',
            onTap: c.onSubmit,
          ),
        ),
      ],
    );
  }

  // ---------- 3. GOOGLE / APPLE ----------
  Widget socialPart() {
    return Row(
      children: [
        Expanded(
          child: SocialButton(
            icon: FontAwesomeIcons.google,
            text: 'Google',
            onTap: c.onGoogle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SocialButton(
            icon: FontAwesomeIcons.apple,
            text: 'Apple',
            onTap: c.onApple,
          ),
        ),
      ],
    );
  }

  // ---------- 4. NEECHE KA TEXT ----------
  Widget bottomText() {
    return Obx(
      () => Wrap(
        alignment: WrapAlignment.center,
        children: [
          Text(
            c.isLoginTab.value
                ? "Don't have an account? "
                : 'Already have an account? ',
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13),
          ),
          GestureDetector(
            onTap: () => c.setTab(c.isLoginTab.value ? 1 : 0),
            child: Text(
              c.isLoginTab.value ? 'Sign Up' : 'Login',
              style: GoogleFonts.poppins(
                color: gold,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationColor: gold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
