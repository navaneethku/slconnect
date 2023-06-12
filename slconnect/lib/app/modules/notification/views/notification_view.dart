import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../consts/common_styles.dart';
import '../controllers/notification_controller.dart';
import 'package:slconnect/app/models/EmployerModel.dart';

import '../../../../consts/colors.dart';
import '../../../../firebase/db.dart';
import '../../../models/BookingModel.dart';
import 'package:intl/intl.dart';
import '../../../../firebase/db.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotificationView'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: DatabaseService().fetchBookingLaborerStream(),
        builder: (context, snapshot1) {
          int laborerListLength = snapshot1.data?.length ?? 0;
          if (snapshot1.hasData) {
            return Center(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: laborerListLength,
                      itemBuilder: (context, index) {
                        BookingModel? booking = snapshot1.data?[index];
                        DateTime startDate = booking!.startDate.toDate();
                        DateTime endDate = booking.endDate.toDate();
                        return FutureBuilder(
                            future: DatabaseService()
                                .getEmployerById(booking.employerId),
                            builder: (context, snapshot2) {
                              if (snapshot2.hasData) {
                                EmployerModel? employer = snapshot2.data;
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: ExpansionTile(
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
                                            employer!.phoneNumber,
                                            style: mediumWhite,
                                          ),
                                        ],
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_drop_down_rounded,
                                        color: index % 2 == 0
                                            ? secondary
                                            : primary,
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
                                                Text("Name of Employer",
                                                    style: index % 2 == 0
                                                        ? mediumSecondaryBold
                                                        : mediumPrimaryBold),
                                                Text(employer!.name,
                                                    style: mediumWhite),
                                                Text("Description",
                                                    style: index % 2 == 0
                                                        ? mediumSecondaryBold
                                                        : mediumPrimaryBold),
                                                Text(booking.workDescription,
                                                    style: mediumWhite),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Skill",
                                                            style: index % 2 ==
                                                                    0
                                                                ? mediumSecondaryBold
                                                                : mediumPrimaryBold),
                                                        Text(booking.skill,
                                                            style: mediumWhite),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Amount Req",
                                                            style: index % 2 ==
                                                                    0
                                                                ? mediumSecondaryBold
                                                                : mediumPrimaryBold),
                                                        Text(
                                                            booking.price
                                                                .toString(),
                                                            style: mediumWhite),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Start",
                                                            style: index % 2 ==
                                                                    0
                                                                ? mediumSecondaryBold
                                                                : mediumPrimaryBold),
                                                        Text(
                                                            DateFormat.yMMMd()
                                                                .format(
                                                                    startDate)
                                                                .toString(),
                                                            style: mediumWhite),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("End Date",
                                                            style: index % 2 ==
                                                                    0
                                                                ? mediumSecondaryBold
                                                                : mediumPrimaryBold),
                                                        Text(
                                                            DateFormat.yMMMd()
                                                                .format(endDate)
                                                                .toString(),
                                                            style: mediumWhite),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 12),
                                                        child: ElevatedButton(
                                                          onPressed: () async{
                                                            DatabaseService
                                                                .addToMyBookingAndRemoveFromNotifications(
                                                                    booking);
                                                            String recDevId = await DatabaseService.getDeviceTokenFromUID(booking.employerId);
                                                            controller.sendPushNotification(recDevId, "I will be able to work on the days you selected");
                                                          },
                                                          child: Text("Accept",
                                                              style:
                                                                  mediumPrimaryBold),
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 12),
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            DatabaseService
                                                                .removeFromNotifications(
                                                                    booking);
                                                            String recDevId =
                                                                await DatabaseService
                                                                    .getDeviceTokenFromUID(
                                                                        booking
                                                                            .employerId);
                                                            debugPrint(booking
                                                                .employerId);
                                                            debugPrint(
                                                                recDevId);
                                                            controller
                                                                .sendPushNotification(
                                                                    recDevId,
                                                                    "I'm sorry I will not be able to take that work");
                                                            debugPrint(
                                                                "PushNotificationToEmployerSuccessful");
                                                          },
                                                          child: Text("Reject",
                                                              style:
                                                                  mediumPrimaryBold),
                                                        ),
                                                      ),
                                                    ]),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            });
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
