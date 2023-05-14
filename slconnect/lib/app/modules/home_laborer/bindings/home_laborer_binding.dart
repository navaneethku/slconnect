import 'package:get/get.dart';

import '../controllers/home_laborer_controller.dart';

class HomeLaborerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeLaborerController>(
      () => HomeLaborerController(),
    );
  }
}
