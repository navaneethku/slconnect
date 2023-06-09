import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  int selectedIndex = 0;
  List<String> skillsList = [
    "Mistri",
    "Painting",
    "Landscaping",
    "Coconut Climbing",
    "Plumbing",
    "Wood Working"
  ];
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print(skillsList);
  
  }



  void increment() => count.value++;

  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }
}
