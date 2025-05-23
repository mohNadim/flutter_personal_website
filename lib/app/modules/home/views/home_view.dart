import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_personal_website/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/app_bar/appbar.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/app_bar/appbar_child.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/about_me/about_me_section.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/main_layer.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/main_section.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/project_section/projects_section.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/skills_section.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';
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
          ),

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
        ],
      ),
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
