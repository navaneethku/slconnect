import 'package:get/get.dart';

import '../controllers/profile_laborer_controller.dart';

class ProfileLaborerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfileLaborerController>(ProfileLaborerController(),
    );
  }
}
