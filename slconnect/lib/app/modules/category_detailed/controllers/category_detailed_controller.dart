import 'package:get/get.dart';
import 'package:slconnect/firebase/db.dart';

class CategoryDetailedController extends GetxController {
  //TODO: Implement CategoryDetailedController

  final count = 0.obs;
  @override
  void onInit() async {
    var laborerListByCategory =
        await DatabaseService().getLaborersByCategory("Mistri");


    super.onInit();
  }

  String laborerCategory = "";
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
