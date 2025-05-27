import 'package:flutter/material.dart';
import 'package:flutter_personal_website/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/app_bar/appbar.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/app_bar/appbar_child.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/about_me/about_me_section.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/contact_us/contuct_us_section.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/main_layer.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/main_section.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/project_section/projects_section.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/section_title.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/skills_section.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
    // required this.controller,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final HomeController controller = Get.put<HomeController>(HomeController());
  late AnimationController _animationController;
  late Animation<Offset> _floatButtonAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 6,
      ),
    );

    _floatButtonAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween(
          begin: Offset(0, 0),
          end: Offset(0, -0.1),
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: Offset(0, -0.1),
          end: Offset(0, 0),
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: Offset(0, 0),
          end: Offset(0, 0.1),
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: Offset(0, 0.1),
          end: Offset(0, 0),
        ),
        weight: 1,
      ),
    ]).animate(_animationController);

    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return SlideTransition(
            position: _floatButtonAnimation,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: InkWell(
                onTap: controller.goToMainSection,
                child: Container(
                  height: 70,
                  width: 60,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Icon(
                      Ionicons.arrow_up,
                      color: AppColor.darkBackgroundColor,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      appBar: CustomAppBar(
        height: 70,
        child: AppBarChild(controller: controller),
      ),
      body: Stack(
        children: [
          const MainLayer(),
          SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => MainSection(
                    isAnimate: controller.isMainSectionAnimate.value,
                  ),
                ),
                Obx(
                  () => AboutMeSection(
                    isAnimate: controller.isAboutSectionAnimate.value,
                  ),
                ),
                Obx(
                  () => SkillsSection(
                    isAnimate: controller.isSkillsSectionAnimate.value,
                    homeController: controller,
                  ),
                ),
                Obx(
                  () => ProjectsSection(
                    isAnimate: controller.isProjectSectionAnimate.value,
                    homeController: controller,
                  ),
                ),
                Obx(
                  () => ContactUs(
                    isAnimate: controller.isContactSectionAnimate.value,
                    homeController: controller,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
