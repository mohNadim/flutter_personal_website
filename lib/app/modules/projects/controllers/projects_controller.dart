import 'package:flutter_personal_website/core/constant/projects_cards.dart';
import 'package:get/get.dart';

class ProjectsController extends GetxController {


  List<RxBool> projectCardsHoverStates =
      List.generate(projectCards.length, (_) => false.obs);

      
  void onHoverProjectCard(int index, bool value) {
    projectCardsHoverStates[index].value = value;
  }

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

}
