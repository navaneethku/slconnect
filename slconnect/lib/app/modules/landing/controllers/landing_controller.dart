import 'package:get/get.dart';

class LandingController extends GetxController {
  //TODO: Implement LandingController

  final count = 0.obs;
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

  void increment() => count.value++;

  bool isSelectedLaborer = false;
  bool isSelectedEmployer = false;
  void selectLaborer() {
    isSelectedEmployer = false;
    isSelectedLaborer = true;
    update();
  }

  void selectEmployer() {
    isSelectedLaborer = false;
    isSelectedEmployer = true;
    update();
  }
}
