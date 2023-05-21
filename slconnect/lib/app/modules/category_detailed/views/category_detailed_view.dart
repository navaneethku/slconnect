import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:slconnect/consts/colors.dart';
import 'package:slconnect/consts/common_styles.dart';
import 'package:slconnect/firebase/db.dart';

import '../../../models/LaborerModel.dart';
import '../controllers/category_detailed_controller.dart';

class CategoryDetailedView extends GetView<CategoryDetailedController> {
  const CategoryDetailedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: DatabaseService().getLaborersByCategory(Get.arguments),
        builder: (BuildContext context,
            AsyncSnapshot<List<LaborerModel?>> snapshot) {
          int laborerListLength = snapshot.data?.length ?? 0;
          if (snapshot.hasData) {
            return Center(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: laborerListLength,
                      itemBuilder: (context, index) {
                        LaborerModel? laborer = snapshot.data?[index];
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
                                    laborer!.name,
                                    style: mediumWhite,
                                  ),
                                  const Spacer(),
                                  const Spacer(),
                                  Icon(
                                    Icons.arrow_drop_down_rounded,
                                    color: index % 2 == 0 ? secondary : primary,
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              trailing: Text(
                                laborer.phoneNumber,
                                style: mediumWhite,
                              ),
                              children: [
                                Container(
                                  color: index % 2 == 0 ? primary : secondary,
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
                                        Text(laborer.description,
                                            style: mediumWhite),
                                        Text("Location",
                                            style: index % 2 == 0
                                                ? mediumSecondaryBold
                                                : mediumPrimaryBold),
                                        Text(laborer.location,
                                            style: mediumWhite),
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
