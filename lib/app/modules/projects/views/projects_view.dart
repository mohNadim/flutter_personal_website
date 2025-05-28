import 'package:flutter/material.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/app_bar/appbar.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/main_layer.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/project_section/project_card.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';
import 'package:flutter_personal_website/core/constant/projects_cards.dart';
import 'package:flutter_personal_website/core/models/project_model.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/projects_controller.dart';

class ProjectsView extends GetView<ProjectsController> {
  const ProjectsView({super.key});

  get fadeAnimation => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          height: 70,
          child: Container(
            color: AppColor.darkColor,
            child: Center(
              child: Text(
                "مشاريعي",
                style: GoogleFonts.tajawal(
                  color: AppColor.lightColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          )),
      body: Stack(
        children: [
          const MainLayer(),
          Center(
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              child: SingleChildScrollView(
                child: Wrap(
                  textDirection: TextDirection.rtl,
                  spacing: 20,
                  runSpacing: 30,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: List.generate(
                    projectCards.length,
                    (index) {
                      ProjectModel card = projectCards[index];
                      return Obx(
                        () => ProjectCard(
                          image: card.image,
                          projectName: card.projectName,
                          projectdiscreption: card.projectdiscreption,
                          tags: card.tags,
                          isHover:
                              controller.projectCardsHoverStates[index].value,
                          onHover: (value) =>
                              controller.onHoverProjectCard(index, value),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
