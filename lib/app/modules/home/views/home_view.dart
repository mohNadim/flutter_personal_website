import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_personal_website/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/app_bar/appbar.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/app_bar/appbar_child.dart';
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainLayer(),
            ],
          ),
        ),
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

class _MainLayer extends State<MainLayer> with TickerProviderStateMixin {
  late AnimationController _glitchController;
  late AnimationController _elementController;
  late AnimationController _particlesController;

  late Animation<Color?> _glitchAnimationColor;
  late Animation<Offset> _glitchAnimationOffset;

  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;

  final int particleCount = 70;
  late List<Particle> particles;

  @override
  void initState() {
    super.initState();

    //* controllers init

    _glitchController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    _elementController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _particlesController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    );

    //* Animations

    //* Glitch Animations *//

    _glitchAnimationColor = TweenSequence<Color?>([
      TweenSequenceItem(
        tween: ColorTween(
            begin: AppColor.primaryColor, end: AppColor.secondaryColor),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(
            begin: AppColor.secondaryColor, end: AppColor.primaryColor),
        weight: 1,
      ),
    ]).animate(_glitchController);

    _glitchAnimationOffset = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween(
          begin: Offset(2.5, 2.5),
          end: Offset(-2.5, 2.5),
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: Offset(-2.5, 2.5),
          end: Offset(2.5, -2.5),
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: Offset(-2.5, 2.5),
          end: Offset(-2.5, -2.5),
        ),
        weight: 1,
      ),
    ]).animate(
      CurvedAnimation(parent: _glitchController, curve: Curves.ease),
    );

    //* Elemnt Animations *//

    _fadeAnimations = List.generate(
      3,
      (index) {
        double start = index * 0.25;
        double end = start + 0.25;

        return Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _elementController,
            curve: Interval(start, end, curve: Curves.easeOut),
          ),
        );
      },
    );

    _slideAnimations = List.generate(
      3,
      (index) {
        double start = index * 0.25;
        double end = start + 0.25;

        return Tween<Offset>(begin: Offset(0, 0.4), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _elementController,
            curve: Interval(start, end, curve: Curves.easeOut),
          ),
        );
      },
    );

    //* Particles Animations *//

    particles = List.generate(
      particleCount,
      (index) =>
          Particle(screenHeight: Get.height - 70, screenWidth: Get.width),
    );

    //* Perform Animations *//

    _particlesController.repeat();
    _elementController.forward().whenComplete(
      () {
        _glitchController.repeat();
      },
    );
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

              MainSection(
                elementController: _elementController,
                glitchController: _glitchController,
                slideAnimations: _slideAnimations,
                fadeAnimations: _fadeAnimations,
                glitchAnimationColor: _glitchAnimationColor,
                glitchAnimationOffset: _glitchAnimationOffset,
              ),
            ],
          ),
        );
      },
    );
  }
}

class MainSection extends StatelessWidget {
  const MainSection({
    super.key,
    required AnimationController elementController,
    required AnimationController glitchController,
    required List<Animation<Offset>> slideAnimations,
    required List<Animation<double>> fadeAnimations,
    required Animation<Color?> glitchAnimationColor,
    required Animation<Offset> glitchAnimationOffset,
  })  : _elementController = elementController,
        _glitchController = glitchController,
        _slideAnimations = slideAnimations,
        _fadeAnimations = fadeAnimations,
        _glitchAnimationColor = glitchAnimationColor,
        _glitchAnimationOffset = glitchAnimationOffset;

  final AnimationController _elementController;
  final AnimationController _glitchController;
  final List<Animation<Offset>> _slideAnimations;
  final List<Animation<double>> _fadeAnimations;
  final Animation<Color?> _glitchAnimationColor;
  final Animation<Offset> _glitchAnimationOffset;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _elementController,
        builder: (context, widget) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //* welcom pharse with Glitch Effect
              AnimatedBuilder(
                animation: _glitchController,
                builder: (context, child) {
                  return SlideTransition(
                    position: _slideAnimations[0],
                    child: FadeTransition(
                      opacity: _fadeAnimations[0],
                      child: Text(
                        "مرحباً بكم في موقعي",
                        style: GoogleFonts.cairo(
                          color: AppColor.lightColor,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: _glitchAnimationColor.value!,
                              offset: _glitchAnimationOffset.value,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 40),

              //* Overview with Typing Effect
              SlideTransition(
                position: _slideAnimations[1],
                child: FadeTransition(
                  opacity: _fadeAnimations[1],
                  child: DefaultTextStyle(
                    style: GoogleFonts.cairo(fontSize: 25),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          "android مطور تطبيقات",
                          cursor: '|',
                          speed: Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          "ios مطور تطبيقات",
                          cursor: '|',
                          speed: Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          "web مطور تطبيقات",
                          cursor: '|',
                          speed: Duration(milliseconds: 100),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              //* Buttuns
              SlideTransition(
                position: _slideAnimations[2],
                child: FadeTransition(
                  opacity: _fadeAnimations[2],
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 40,
                          ),
                          backgroundColor: AppColor.darkColor,
                          overlayColor: Colors.transparent,
                          elevation: 0,
                          side: BorderSide(
                            color: AppColor.secondaryColor,
                          ),
                        ),
                        child: Text(
                          "تواصل معي",
                          style: GoogleFonts.cairo(
                            color: AppColor.secondaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 40,
                          ),
                          backgroundColor: AppColor.primaryColor,
                          overlayColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Text(
                          "مشاهدة أعمالي",
                          style: GoogleFonts.cairo(
                            color: AppColor.lightColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
