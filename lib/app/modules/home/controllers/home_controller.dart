import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<RxBool> hoverStates = List.generate(4, (_) => false.obs);
  RxDouble offset = 0.0.obs;

  final isMainSectionAnimate = false.obs;
  final isAboutSectionAnimate = false.obs;
  final isSkillsSectionAnimate = false.obs;
  late ScrollController scrollController;

  final List<double> _steps = [0, 50, 100, 150, 200]; // النقاط التي ينقل إليها
  int _currentStep = 0;
  double _lastOffset = 0;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(
      () {
        // print(scrollController.position.pixels);
        _handleScroll();
      },
    );
  }

  void _handleScroll() {
    double offset = scrollController.offset;

    if (!scrollController.position.isScrollingNotifier.value) return;

    if (offset > _lastOffset && _currentStep < _steps.length - 1) {
      _currentStep++;
      print("up to  $_currentStep");
      _animateToStep();
      _handleControllers();
    } else if (offset < _lastOffset && _currentStep > 0) {
      _currentStep--;
      print("down to  $_currentStep");
      _animateToStep();
      _handleControllers();
    }

    _lastOffset = offset;
  }

  void _animateToStep() {
    scrollController.jumpTo(
      _steps[_currentStep],
    );
  }

  void _handleControllers() {
    if (_currentStep == 0) {
      isMainSectionAnimate.value = false;
      isAboutSectionAnimate.value = false;
    } else if (_currentStep == 1) {
      isMainSectionAnimate.value = true;
      isAboutSectionAnimate.value = true;
    } else if (_currentStep == 2) {
      isAboutSectionAnimate.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void onHover(int index, bool value) {
    hoverStates[index].value = value;
  }

  bool isMobile() => Get.width < 600;
}
