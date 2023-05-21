import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  bool isButtonActive = false;
  void checkIsButtonActive() {
    if (isSelectedLaborer || isSelectedEmployer) {
      isButtonActive = true;
    }
    update();
  }
  Future<bool> checkIsLaborer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var laborer = prefs.containsKey('laborer');
    print("Printing Inside checkIsLaborer");
    print(laborer);
    return laborer;
  }
}
