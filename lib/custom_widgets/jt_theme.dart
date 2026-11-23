import 'package:flutter/material.dart';

class JT {
  static const Color bg = Color(0xFF0F1A13);
  static const Color card = Color(0xFF1B2A20);
  static const Color cardBorder = Color(0xFF2A3D30);
  static const Color gold = Color(0xFFD4AF37);
  static const Color muted = Color(0xFF8E9B90);

  static const LinearGradient bgGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0F1A13), Color(0xFF0A120D)],
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFF7E29C), Color(0xFFC59A3F)],
  );

  static const TextStyle heading = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
}
