import 'package:flutter/material.dart';
import 'package:flutter_personal_website/core/constant/skills_card.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late ScrollController scrollController;

  RxDouble offset = 0.0.obs;

  final isMainSectionAnimate = false.obs;
  final isAboutSectionAnimate = false.obs;
  final isSkillsSectionAnimate = false.obs;
  final isProjectSectionAnimate = false.obs;
  final isContactSectionAnimate = false.obs;

  List<RxBool> hoverStates = List.generate(5, (_) => false.obs);
  List<RxBool> skillsHoverStates =
      List.generate(skills.length, (_) => false.obs);
  List<RxBool> projectCardsHoverStates =
      List.generate(skills.length, (_) => false.obs);

  final double sectionHeight = Get.height - 70;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_handleScroll);

    // تأخير طفيف لضمان ربط الـ ScrollController قبل الفحص
    Future.delayed(Duration(milliseconds: 100), _handleScroll);
  }

  void _handleScroll() {
    if (!scrollController.hasClients) return;

    double offset = scrollController.offset;
    this.offset.value = offset;

    double triggerFactor = 0.3;

    // About Section
    if (offset >= sectionHeight * 1 - sectionHeight * triggerFactor &&
        offset < sectionHeight * 2) {
      isAboutSectionAnimate.value = true;
    }

    // Skills Section
    if (offset >= sectionHeight * 2 - sectionHeight * triggerFactor &&
        offset < sectionHeight * 3) {
      isSkillsSectionAnimate.value = true;
    }

    // Projects Section
    if (offset >= sectionHeight * 3 - sectionHeight * triggerFactor &&
        offset < sectionHeight * 4) {
      isProjectSectionAnimate.value = true;
    }

    // Contact Section
    if (offset >= sectionHeight * 4 - sectionHeight * triggerFactor) {
      isContactSectionAnimate.value = true;
    }

    // Debug فقط
    // print('offset: $offset | main: ${isMainSectionAnimate.value}');
  }

  void onHover(int index, bool value) {
    hoverStates[index].value = value;
  }

  void onHoverSkill(int index, bool value) {
    skillsHoverStates[index].value = value;
  }

  void onHoverProjectCard(int index, bool value) {
    projectCardsHoverStates[index].value = value;
  }

  void goToMainSection() {
    scrollController.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.easeInOutQuint);
  }

  void goToAboutSection() {
    scrollController.animateTo((sectionHeight + 60),
        duration: Duration(seconds: 1), curve: Curves.easeInOutQuint);
  }

  void goToSkillsSection() {
    scrollController.animateTo((sectionHeight + 60) * 2,
        duration: Duration(seconds: 1), curve: Curves.easeInOutQuint);
  }

  void goToProjectsSection() {
    scrollController.animateTo((sectionHeight + 60) * 3,
        duration: Duration(seconds: 1), curve: Curves.easeInOutQuint);
  }

  void goToContactUsSection() {
    scrollController.animateTo((sectionHeight + 60) * 4,
        duration: Duration(seconds: 1), curve: Curves.easeInOutQuint);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
