import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../consts/firebase_consts.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;
  bool isLaborer = false;
  var phoneNumber = '';
  @override
  void onInit() async {
    isLaborer = await checkIsLaborer();
    update();
    print(isLaborer);
    phoneNumber = getPhoneNumberOfCurrentUser() ?? "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Is the laborer key in memory?" +
        prefs.containsKey("laborer").toString());
    prefs.remove("laborer");
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
  void increment() => count.value++;
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  bool isLoading = false;
  String? getPhoneNumberOfCurrentUser() {
    if (currentUser != null) {
      for (final providerProfile in currentUser!.providerData) {
        final provider = providerProfile.providerId;
        final uid = providerProfile.uid;
        return providerProfile.phoneNumber;
      }
    }
    return null;
  }

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
    if (laborer == null) {
      return "employer";
    } else {
      return 'laborer';
    }
  }

  Future<bool> checkIsLaborer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var laborer = prefs.containsKey('laborer');
    print("Printing Inside checkIsLaborer");
    print(laborer);
    return laborer;
  }
}
