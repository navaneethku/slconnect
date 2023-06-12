import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:slconnect/app/models/EmployerModel.dart';

import '../../../../consts/colors.dart';
import '../../../../consts/common_styles.dart';
import '../../../../firebase/db.dart';
import '../../../models/BookingModel.dart';
import '../../../models/LaborerModel.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/BottomNavigation.dart';
import '../controllers/booking_controller.dart';
import 'package:intl/intl.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 1,
      ),
      appBar: AppBar(
        title: const Text('BookingView'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: DatabaseService().fetchBookingLaborerForBookingPageStream(),
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
