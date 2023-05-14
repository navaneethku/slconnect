import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

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

  final employerFormKey = GlobalKey<FormState>();
  final laborerFormKey = GlobalKey<FormState>();
  void increment() => count.value++;
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  bool isLoading = false;

  void setLoading() {
    isLoading = true;
    update();
  }

  void setLoadingFalse() {
    isLoading = false;
    update();
  }
  //getTheRollOf the user from the value stored in shared preferences in the loading page
  Future<String?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var laborer = prefs.getString('laborer');
    var employer = prefs.getString('employer');
    if (laborer == null) {
      return employer;
    } else {
      return laborer;
    }
  }
}
