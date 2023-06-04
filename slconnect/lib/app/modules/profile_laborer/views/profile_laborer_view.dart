import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:slconnect/consts/firebase_consts.dart';

import '../../../../consts/colors.dart';
import '../../../../consts/common_styles.dart';
import '../../../../firebase/db.dart';
import '../../../models/LaborerModel.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/BottomNavigation.dart';
import '../controllers/profile_laborer_controller.dart';
import 'package:intl/intl.dart';

class ProfileLaborerView extends GetView<ProfileLaborerController> {
  const ProfileLaborerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomNavigation(
          currentIndex: 2,
        ),
        appBar: AppBar(
          elevation: 1,
          title: const Text(
            'Laborer Profile',
            style: largePrimaryBold,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: GetBuilder<ProfileLaborerController>(
              builder: (_) => controller.isLaborer
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/background.gif"),
                              fit: BoxFit.cover)),
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                      child: Column(children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Create Profile",
                            style: largePrimaryBold,
                          ),
                        ),
                        Form(
                            key: controller.laborerFormKey,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Name', style: textStyle),
                                    const SizedBox(height: 10.0),
                                    TextFormField(
                                      controller: controller.nameController,
                                      keyboardType: TextInputType.text,
                                      decoration: inputDecoration.copyWith(
                                          fillColor: Colors.white,
                                          focusColor: Colors.white,
                                          hintText: "Enter your Name"),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Name';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10.0),
                                    const Text('Age', style: textStyle),
                                    const SizedBox(height: 10.0),
                                    TextFormField(
                                      controller: controller.ageController,
                                      keyboardType: TextInputType.text,
                                      decoration: inputDecoration.copyWith(
                                          hintText: "Enter your Age"),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Age';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10.0),
                                    const Text('Location', style: textStyle),
                                    const SizedBox(height: 10.0),
                                    TextFormField(
                                      controller: controller.locationController,
                                      keyboardType: TextInputType.text,
                                      decoration: inputDecoration.copyWith(
                                          hintText: "Enter your Location"),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Location';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10.0),
                                    const Text('Description', style: textStyle),
                                    const SizedBox(height: 10.0),

                                    TextFormField(
                                      controller:
                                          controller.descriptionController,
                                      keyboardType: TextInputType.text,
                                      decoration: inputDecoration.copyWith(
                                          hintText: "Enter your Description"),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Description';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10.0),
                                    ElevatedButton(
                                      onPressed: controller.showMultiSelect,
                                      child: const Text('Select Your Skills'),
                                    ),
                                    const Divider(
                                      height: 30,
                                    ),
                                    // display selected items
                                    Wrap(
                                      children: controller.selectedItems
                                          .map((e) => Chip(
                                                label: Text(e),
                                              ))
                                          .toList(),
                                    ),
                                    const SizedBox(height: 20.0),
                                    !controller.isLoading
                                        ? Center(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    foregroundColor: primary),
                                                onPressed: (() async {
                                                  var tempRole =
                                                      await controller
                                                          .getUserRole();
                                                  if (controller.laborerFormKey
                                                      .currentState!
                                                      .validate()) {
                                                    DatabaseService service =
                                                        DatabaseService();
                                                    print(controller
                                                        .ageController.text);
                                                    print(controller
                                                        .nameController.text);
                                                    print(controller
                                                        .locationController
                                                        .text);
                                                    print(tempRole);
                                                    LaborerModel laborer =
                                                        LaborerModel(
                                                      name: controller
                                                          .nameController.text,
                                                      age: controller
                                                          .ageController.text,
                                                      location: controller
                                                          .locationController
                                                          .text,
                                                      description: controller
                                                          .descriptionController
                                                          .text,
                                                      role: tempRole ?? "",
                                                      phoneNumber: controller
                                                          .phoneNumber,
                                                      skills: controller
                                                          .selectedItems,
                                                    );
                                                    controller.setLoading();
                                                    await service
                                                        .addLaborer(laborer);
                                                    controller
                                                        .setLoadingFalse();
                                                    //TODO GO TO Routes.HOME if role == employer, else Routes.HOME_LABORER
                                                    Get.offAndToNamed(
                                                        Routes.HOME_LABORER);
                                                  }
                                                }),
                                                child: const Text(
                                                  "Submit",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                )),
                                          )
                                        : const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                  ]),
                            ))
                      ]))
                  : Container(
                      height: double.maxFinite,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                LaborerModel? laborer = Get.arguments;
                                debugPrint(laborer?.id);
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: ExpansionTile(
                                      initiallyExpanded: true,
                                      shape: const Border(),
                                      collapsedBackgroundColor:
                                          index % 2 == 0 ? primary : secondary,
                                      backgroundColor:
                                          index % 2 == 0 ? primary : secondary,
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            laborer?.name ?? "",
                                            style: mediumWhite,
                                          ),
                                          const Spacer(),
                                          const Spacer(),
                                          Icon(
                                            Icons.arrow_drop_down_rounded,
                                            color: index % 2 == 0
                                                ? secondary
                                                : primary,
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                      trailing: Text(
                                        laborer?.phoneNumber ?? "",
                                        style: mediumWhite,
                                      ),
                                      children: [
                                        Container(
                                          width: double.maxFinite,
                                          color: index % 2 == 0
                                              ? primary
                                              : secondary,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 20, 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Description",
                                                    style: index % 2 == 0
                                                        ? mediumSecondaryBold
                                                        : mediumPrimaryBold),
                                                Text(laborer?.description ?? "",
                                                    style: mediumWhite),
                                                Text("Location",
                                                    style: index % 2 == 0
                                                        ? mediumSecondaryBold
                                                        : mediumPrimaryBold),
                                                Text(laborer?.location ?? "",
                                                    style: mediumWhite),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: MaterialButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16)),
                                                    color: Theme.of(context)
                                                        .cardColor,
                                                    onPressed: () async {
                                                      debugPrint(
                                                          currentUser!.uid);
                                                      debugPrint(
                                                          "DocID of Laborer is :${laborer!.id}");
                                                      controller
                                                              .targetLaborerDocId =
                                                          laborer.id!;

                                                      controller.deviceToken =
                                                          await controller
                                                              .getDeviceTokenFromUser(
                                                                  controller
                                                                      .targetLaborerDocId);
                                                      debugPrint(
                                                          "Device Id of Laborer is :${controller.deviceToken}");
                                                      controller
                                                          .sendPushNotification(
                                                              controller
                                                                  .deviceToken,
                                                              "${currentUser!.phoneNumber} has booked you ${DateFormat.yMMMMd().format(DateTime.now())}");
                                                    },
                                                    child: const Text(
                                                        "Book Laborer"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )),
        ));
  }
}
