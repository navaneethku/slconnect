import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../consts/firebase_consts.dart';
import '../../../widgets/MultiSelect.dart';

class ProfileLaborerController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;
  bool isLaborer = false;
  var phoneNumber = '';
  @override
  void onInit() async {
    phoneNumber = getPhoneNumberOfCurrentUser() ?? "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Is the laborer key in memory?" +
        prefs.containsKey("laborer").toString());
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

  List<String> selectedItems = [];

  void showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> items = [
      'Mistri',
      'Painting',
      'Landscaping',
      'Coconut Climbing',
      'Plumbing',
      'Wood Working'
    ];

    final List<String>? results = await Get.dialog(MultiSelect(items: items));
    // Update UI
    if (results != null) {
      update();
      selectedItems = results;
    }
  }

  final laborerFormKey = GlobalKey<FormState>();
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
