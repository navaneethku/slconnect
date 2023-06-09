import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slconnect/firebase/db.dart';

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
              future: DatabaseService().getEmployerById(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(snapshot.data?.id??"id not entered"),
                      Text(snapshot.data?.name ?? "name not entered"),
                      Text(snapshot.data?.location ?? "location not entered"),
                      Text(snapshot.data?.age ?? "age not entered"),
                      Text(snapshot.data?.phoneNumber ??
                          "phoneNumber not entered"),
                      Text(snapshot.data?.role ?? "role not defined")
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
                  Get.offAndToNamed(Routes.LOGIN);
                },
                child: const Text("Log Out")),
          ],
        ),
      ),
    );
  }
}
