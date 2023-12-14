import 'package:get/get.dart';

import '../controllers/category_detailed_controller.dart';

class CategoryDetailedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryDetailedController());
  }
}
