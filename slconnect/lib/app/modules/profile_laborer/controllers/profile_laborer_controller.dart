import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slconnect/firebase/db.dart';
import '../../../../consts/common_instances.dart';
import '../../../models/LaborerModel.dart';
import '../../../widgets/MultiSelect.dart';

class ProfileLaborerController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;
  bool isLaborer = true;
  bool hasCreatedProfile = false;
  String targetLaborerDocId = "";
  var phoneNumber = '';
  String deviceToken = "";
  @override
  void onInit() async {
    super.onInit();
    phoneNumber = getPhoneNumberOfCurrentUser() ?? "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("laborer")) {
      isLaborer = true;
    }
    debugPrint("Is the laborer key in memory?${prefs.containsKey("laborer")}");
    checkCreatedProfile();
  }



  List<String> selectedItems = [];

  Future<String> getDeviceTokenFromUser(String docId) async {
    final collectionRef = FirebaseFirestore.instance.collection("UserTokens");
    final documentSnapshot = await collectionRef.doc(docId).get();
    if (documentSnapshot.exists) {
      final data = documentSnapshot.data();
      if (data!.containsKey('token')) {
        final token = data['token'] as String;
        return token;
      } else {
        throw Exception("Token not found in the document.");
      }
    } else {
      throw Exception("Document with ID '$docId' does not exist.");
    }
  }
// Future<String> getPlayerId(String deviceToken) async {
//   final url = Uri.parse('https://onesignal.com/api/v1/players');
//   final headers = {
//     'Content-Type': 'application/json',
//     'Authorization': oneSignalApiKey,
//   };

//   final queryParams = {
//     'app_id': "05849719-1b2a-453c-a8d7-981308d70e22",
//     'identifier': deviceToken,
//   };

//   final uri = Uri(
//     scheme: url.scheme,
//     host: url.host,
//     path: url.path,
//     queryParameters: queryParams,
//   );

//   final response = await http.get(uri, headers: headers);

//   if (response.statusCode == 200) {
//     final responseData = jsonDecode(response.body);
//     final playerId = responseData['players'][0]['id'];
//     return playerId;
//   } else {
//     throw Exception('Failed to retrieve player ID. Error: ${response.statusCode}');
//   }
// }

  void sendPushNotification(
      String recipientDeviceToken, String notificationMessage) async {
    var notification = OSCreateNotification(
      playerIds: [recipientDeviceToken],
      content: notificationMessage,
    );

    var response = await OneSignal.shared.postNotification(notification);

    if (response.containsKey('status')) {
      var status = response['status'];
      if (status == 'success') {
        debugPrint('Push notification sent successfully!');
      } else {
        debugPrint(
            'Failed to send push notification. Error: ${response.toString()}');
      }
    } else {
      debugPrint(
          'Failed to send push notification. Invalid response: ${response.toString()}');
    }
  }

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
          'Electrician'
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

  void setCreatedProfile() async {
    var hasCreatedProfileLaborer = await prefs;
    hasCreatedProfileLaborer.setBool("hasCreatedProfileLaborer", true);
  }

  void checkCreatedProfile() async {
    var hasCreatedProfileLaborer = await prefs;
    if (hasCreatedProfileLaborer.getBool("hasCreatedProfileLaborer") == true) {
      hasCreatedProfile = true;
      LaborerModel? em = await DatabaseService().getLaborerById();
      nameController.text = em?.name ?? "";
      ageController.text = em?.age ?? "";
      descriptionController.text = em?.description ?? "";
      locationController.text = em?.location ?? "";
      update();
    }
  }
}
