import 'package:flutter/material.dart';
import 'package:flutter_personal_website/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/project_section/project_card.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/section_title.dart';
import 'package:flutter_personal_website/app/routes/app_pages.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';
import 'package:flutter_personal_website/core/constant/projects_cards.dart';
import 'package:flutter_personal_website/core/models/project_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({
    super.key,
    required this.isAnimate,
    required this.homeController,
  });
  final bool isAnimate;
  final HomeController homeController;

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> slideToUpAnimation;
  late Animation<Offset> slideToRightAnimation;
  late Animation<Offset> slideToLeftAnimation;
  late Animation<double> fadeAnimation;

  bool isButtonHover = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    slideToUpAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset.zero,
    ).animate(_controller);

    slideToLeftAnimation = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset.zero,
    ).animate(_controller);

    slideToRightAnimation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset.zero,
    ).animate(_controller);

    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant ProjectsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimate) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      constraints: BoxConstraints(
        minHeight: Get.height,
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                // color: Colors.blue,
                child: FadeTransition(
                  opacity: fadeAnimation,
                  child: SlideTransition(
                    position: slideToUpAnimation,
                    child: SectionTitle(
                      title: "مشاريعي",
                      bottomPadding: 0,
                    ),
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(maxWidth: Get.width * 0.7),
                child: Wrap(
                  textDirection: TextDirection.rtl,
                  spacing: 20,
                  runSpacing: 30,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: List.generate(
                    2,
                    (index) {
                      ProjectModel card = projectCards[index];
                      return FadeTransition(
                        opacity: fadeAnimation,
                        child: SlideTransition(
                          position: index % 2 == 0
                              ? slideToLeftAnimation
                              : slideToRightAnimation,
                          child: Obx(
                            () => ProjectCard(
                              image: card.image,
                              projectName: card.projectName,
                              projectdiscreption: card.projectdiscreption,
                              tags: card.tags,
                              isHover: widget.homeController
                                  .projectCardsHoverStates[index].value,
                              onHover: (value) => widget.homeController
                                  .onHoverProjectCard(index, value),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              FadeTransition(
                opacity: fadeAnimation,
                child: SlideTransition(
                  position: slideToUpAnimation,
                  child: MouseRegion(
                    onEnter: (event) => setState(() => isButtonHover = true),
                    onExit: (event) => setState(() => isButtonHover = false),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.PROJECTS);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 40,
                        ),
                        backgroundColor: isButtonHover
                            ? AppColor.hoverPrimaryColor
                            : AppColor.primaryColor,
                        overlayColor: Colors.transparent,
                        elevation: 0,
                      ),
                      child: Text(
                        "عرض كل المشاريع",
                        style: GoogleFonts.cairo(
                          color: AppColor.lightColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
