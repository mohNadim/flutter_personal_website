import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';
import 'package:flutter_personal_website/core/models/particle.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MainLayer extends StatefulWidget {
  const MainLayer({
    super.key,
  });

  @override
  State<MainLayer> createState() => _MainLayer();
}

class _MainLayer extends State<MainLayer> with SingleTickerProviderStateMixin {
  late AnimationController _particlesController;

  final int particleCount = 70;
  late List<Particle> particles;

  @override
  void initState() {
    super.initState();

    //* controllers init

    _particlesController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    );

    particles = List.generate(
      particleCount,
      (index) =>
          Particle(screenHeight: Get.height - 70, screenWidth: Get.width),
    );

    //* Perform Animations *//

    _particlesController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _particlesController,
      builder: (context, child) {
        return Container(
          width: Get.width,
          height: Get.height - 70,
          color: AppColor.darkColor,
          child: Stack(
            children: [
              //* Particles
              ...particles.map(
                (p) {
                  return Positioned(
                    top: p.startY +
                        sin(_particlesController.value * 2 * pi + p.phase) * 30,
                    left: p.startX +
                        cos(_particlesController.value * 2 * pi + p.phase) * 30,
                    child: Container(
                      width: p.size,
                      height: p.size,
                      decoration: BoxDecoration(
                        color: p.color,
                        borderRadius: BorderRadius.circular(p.size / 2),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
