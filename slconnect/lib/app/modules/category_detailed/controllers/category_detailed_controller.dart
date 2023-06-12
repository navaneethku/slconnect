import 'package:get/get.dart';

class CategoryDetailedController extends GetxController {
  //TODO: Implement CategoryDetailedController

  final count = 0.obs;
  String laborerCurrentSkill = "";
  @override
  void onInit() {
    laborerCurrentSkill = Get.arguments;
    super.onInit();
  }

  String laborerCategory = "";

  void increment() => count.value++;
}
