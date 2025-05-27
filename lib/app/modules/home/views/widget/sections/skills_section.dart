import 'package:flutter/material.dart';
import 'package:flutter_personal_website/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/section_title.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';
import 'package:flutter_personal_website/core/constant/skills_card.dart';
import 'package:flutter_personal_website/core/models/skills_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection(
      {super.key, required this.isAnimate, required this.homeController});
  final bool isAnimate;
  final HomeController homeController;

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> slidToUpAnimation;
  late Animation<double> fadeAnimation;

  late List<Animation<double>> scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    slidToUpAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset.zero,
    ).animate(_controller);

    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    scaleAnimation = List.generate(
      skills.length,
      (index) {
        double start = index * (1 / skills.length);
        double end = start + (1 / skills.length);
        return Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              start,
              end,
              curve: Curves.easeInOut,
            ),
          ),
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant SkillsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimate) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: Get.height,
        minWidth: Get.width,
      ),
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 60,
            children: [
              //* Title of Section
              FadeTransition(
                opacity: fadeAnimation,
                child: SlideTransition(
                  position: slidToUpAnimation,
                  child: SectionTitle(title: "مهاراتي"),
                ),
              ),

              SizedBox(
                width: Get.width * 0.7,
                child: Wrap(
                  spacing: 20,
                  runSpacing: 30,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: List.generate(
                    skills.length,
                    (index) {
                      SkillsModel skill = skills[index];
                      return Obx(
                        () => FadeTransition(
                          opacity: fadeAnimation,
                          child: ScaleTransition(
                            scale: scaleAnimation[index],
                            child: SkillItem(
                              skill: skill,
                              isHover: widget.homeController
                                  .skillsHoverStates[index].value,
                              onHover: (value) => widget.homeController
                                  .onHoverSkill(index, value),
                            ),
                          ),
                        ),
                      );
                    },
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

class SkillItem extends StatefulWidget {
  const SkillItem({
    super.key,
    required this.skill,
    required this.isHover,
    this.onHover,
  });

  final SkillsModel skill;
  final bool isHover;
  final void Function(bool)? onHover;
  @override
  State<SkillItem> createState() => _SkillItemState();
}

class _SkillItemState extends State<SkillItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;

  late Animation<Offset> _slidToUp;

  @override
  void initState() {
    super.initState();
    // _initAnimationController = AnimationController(
    //   vsync: this,
    //   duration: Duration(milliseconds: 1000),
    // );
    _hoverController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _slidToUp = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, -0.04),
    ).animate(_hoverController);
  }

  @override
  void didUpdateWidget(covariant SkillItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isHover != oldWidget.isHover) {
      widget.isHover ? _hoverController.forward() : _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => widget.onHover?.call(true),
      onExit: (_) => widget.onHover?.call(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, _) {
            return TweenAnimationBuilder<Color?>(
              tween: ColorTween(
                begin: AppColor.lightColor,
                end: widget.isHover
                    ? AppColor.primaryColor
                    : AppColor.lightColor,
              ),
              duration: Duration(milliseconds: 200),
              builder: (context, color, child) => SlideTransition(
                position: _slidToUp,
                child: Container(
                  width: 200,
                  height: 200,
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColor.darkColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 222, 226, 227),
                        blurRadius: 5,
                        spreadRadius: widget.isHover ? 1 : 0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 40,
                      children: [
                        FaIcon(
                          widget.skill.icon,
                          color: color,
                          size: 70,
                        ),
                        Text(
                          widget.skill.skillName,
                          style: GoogleFonts.cairo(
                            color: color,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
