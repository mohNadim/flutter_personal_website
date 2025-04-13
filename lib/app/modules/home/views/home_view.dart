import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_personal_website/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/app_bar/appbar.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/app_bar/appbar_child.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/about_me/about_me_section.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/main_section.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/skills_section.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';
import 'package:flutter_personal_website/core/static_models/particle.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 70,
        child: AppBarChild(controller: controller),
      ),
      body: Stack(
        children: [
          MainLayer(),
          // SectionPlaceholder(),
          Obx(
            () => SkillsSection(isAnimate: controller.isSkillsSectionAnimate.value,),
          ),

          Obx(
            () => AboutMeSection(
              isAnimate: controller.isAboutSectionAnimate.value,
            ),
          ),
          Obx(
            () => MainSection(
              isAnimate: controller.isMainSectionAnimate.value,
            ),
          ),
          SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 2,
                  width: Get.width,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

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

class SectionPlaceholder extends StatelessWidget {
  const SectionPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      alignment: Alignment.center,
      child: Text(
        'سكشن جديد',
        style: GoogleFonts.cairo(
          fontSize: 30,
          color: AppColor.lightColor,
        ),
      ),
    );
  }
}
