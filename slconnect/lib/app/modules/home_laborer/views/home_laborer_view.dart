import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:slconnect/app/widgets/BottomNavigation.dart';
import 'package:slconnect/app/widgets/event_calendar.dart';
import 'package:slconnect/consts/common_instances.dart';

import '../../../../consts/colors.dart';
import '../../../../consts/common_styles.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_laborer_controller.dart';

class HomeLaborerView extends GetView<HomeLaborerController> {
  const HomeLaborerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: secondary,
          title: const Text(
            "Home Labour View",
            style: largePrimaryBold,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                  onTap: () => Get.toNamed(Routes.NOTIFICATION),
                  child: const Icon(
                    Icons.notifications_active,
                    color: primary,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                  onTap: () => Get.toNamed(Routes.SETTINGS),
                  child: const Icon(Icons.settings, color: primary)),
            )
          ]),
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 0,
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: const Text(
                    "Choose whether you are available to be employed by interested employers",
                  ),
                ),
                GetBuilder<HomeLaborerController>(
                  builder: (_) => Align(
                    alignment: Alignment.center,
                    child: StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("availability")
                            .doc(currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          bool isAvailable = snapshot.data!.get("availability");
                          return CupertinoSwitch(
                            focusColor: primary,
                            activeColor: secondary,
                            value: isAvailable,
                            onChanged: ((newValue) {
                              FirebaseFirestore.instance
                                  .collection('availability')
                                  .doc(currentUser!.uid)
                                  .update({'availability': newValue});
                              debugPrint(_.laborerIsAvailable.toString());
                              controller.update();
                            }),
                          );
                        }),
                  ),
                )
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height / 2,
              child: const EventCalendarScreen()),
        ],
      )),
    );
  }
}
