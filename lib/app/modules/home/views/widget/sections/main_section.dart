import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MainSection extends StatefulWidget {
  const MainSection({
    super.key,
    required this.isAnimate,
  });

  final bool isAnimate;

  @override
  State<MainSection> createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection>
    with TickerProviderStateMixin {
  late AnimationController _glitchController;
  late AnimationController _elementController;
  late AnimationController _scrollController;

  late Animation<Color?> _glitchAnimationColor;
  late Animation<Offset> _glitchAnimationOffset;

  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;

  late List<Animation<double>> _scrollFadeAnimations;
  late List<Animation<Offset>> _scrollSlideAnimations;

  bool _isInitAnimate = false;

  @override
  void initState() {
    super.initState();

    _glitchController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    _elementController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _scrollController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

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

    //* Element Animations *//

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
    _scrollFadeAnimations = List.generate(
      3,
      (index) {
        double start = index * 0.25;
        double end = start + 0.25;

        return Tween<double>(begin: 1, end: 0).animate(
          CurvedAnimation(
            parent: _scrollController,
            curve: Interval(start, end, curve: Curves.easeOut),
          ),
        );
      },
    );

    _scrollSlideAnimations = List.generate(
      3,
      (index) {
        double start = index * 0.25;
        double end = start + 0.25;

        return index % 2 == 0
            ? Tween<Offset>(begin: Offset.zero, end: Offset(1, 0)).animate(
                CurvedAnimation(
                  parent: _scrollController,
                  curve: Interval(start, end, curve: Curves.linear),
                ),
              )
            : Tween<Offset>(begin: Offset.zero, end: Offset(-1, 0)).animate(
                CurvedAnimation(
                  parent: _scrollController,
                  curve: Interval(start, end, curve: Curves.linear),
                ),
              );
      },
    );

    _elementController.forward().whenComplete(
      () {
        setState(() {
          _isInitAnimate = true;
        });
        _glitchController.repeat();
      },
    );
  }

  @override
  void didUpdateWidget(covariant MainSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimate) {
      _scrollController.forward();
    } else {
      _scrollController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: _scrollController,
          builder: (context, _) {
            return AnimatedBuilder(
              animation: _elementController,
              builder: (context, _) {
                return Container(
                  height: Get.height - 70,
                  constraints: BoxConstraints(
                    minHeight: Get.height - 70,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //* Welcome Phrase with Glitch Effect
                            AnimatedBuilder(
                              animation: _glitchController,
                              builder: (context, child) {
                                return SlideTransition(
                                  position: _scrollSlideAnimations[0],
                                  child: FadeTransition(
                                    opacity: _scrollFadeAnimations[0],
                                    child: SlideTransition(
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
                                                color: _glitchAnimationColor
                                                    .value!,
                                                offset: _glitchAnimationOffset
                                                    .value,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 40),

                            //* Overview with Typing Effect
                            SlideTransition(
                              position: _scrollSlideAnimations[1],
                              child: FadeTransition(
                                opacity: _scrollFadeAnimations[1],
                                child: SlideTransition(
                                  position: _slideAnimations[1],
                                  child: FadeTransition(
                                    opacity: _fadeAnimations[1],
                                    child: DefaultTextStyle(
                                      style: GoogleFonts.cairo(
                                        fontSize: 25,
                                        color: AppColor.lightColor,
                                      ),
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
                              ),
                            ),

                            const SizedBox(height: 40),

                            //* Buttons
                            SlideTransition(
                              position: _scrollSlideAnimations[2],
                              child: FadeTransition(
                                opacity: _scrollFadeAnimations[2],
                                child: SlideTransition(
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
                                            backgroundColor:
                                                AppColor.primaryColor,
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
