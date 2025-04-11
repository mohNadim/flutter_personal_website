import 'package:get/get.dart';

class HomeController extends GetxController {
  List<RxBool> hoverStates = List.generate(4, (_) => false.obs);
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onHover(int index, bool value) {
    hoverStates[index].value = value;
  }

  bool isMobile() => Get.width < 600;
}
