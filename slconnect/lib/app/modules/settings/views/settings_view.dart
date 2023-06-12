import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slconnect/firebase/db.dart';

import '../../../../consts/common_instances.dart';
import '../../../routes/app_pages.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SettingsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: DatabaseService().getEmployer(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text("UID : ${currentUser!.uid}"),
                      Text("Name : ${snapshot.data!.name}"),
                      Text("Location : ${snapshot.data!.location}"),
                      Text("Age : ${snapshot.data!.age}"),
                      Text("Phone Number : ${snapshot.data!.phoneNumber}"),
                      Text("Role : ${snapshot.data!.role}")
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('phone');
                  prefs.clear();
                  Get.offAndToNamed(Routes.LOGIN);
                },
                child: const Text("Log Out")),
          ],
        ),
      ),
    );
  }
}
