// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';


class Particle {
  final double startX;
  final double startY;
  final double size;
  final Color color;
  final double phase;
  final double screenWidth;
  final double screenHeight;

  Particle({required this.screenHeight, required this.screenWidth})
      : startX = Random().nextDouble() * screenWidth,
        startY = Random().nextDouble() * screenHeight,
        size = Random().nextDouble() * 4,
        color =
            Colors.white.withValues(alpha: 0.4 + Random().nextDouble() * 0.5),
        phase = Random().nextDouble() * 2 * pi;

  @override
  String toString() {
    return 'Particle(startX: $startX, startY: $startY, size: $size, color: $color, phase: $phase, screenWidth: $screenWidth, screenHeight: $screenHeight)';
  }
}
