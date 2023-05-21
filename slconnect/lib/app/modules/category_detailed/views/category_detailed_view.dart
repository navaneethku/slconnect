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
        title: const Text('CategoryDetailedView'),
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
                  Text(
                    Get.arguments,
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: laborerListLength,
                      itemBuilder: (context, index) {
                        LaborerModel? laborer = snapshot.data?[index];
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Card(
                            color: index % 2 == 0 ? primary : secondary,
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          laborer!.name,
                                          style: mediumWhite,
                                        ),
                                        Text(
                                          laborer.phoneNumber,
                                          style: mediumWhite,
                                        )
                                      ]),
                                  Text(
                                    laborer.age,
                                    style: mediumWhite,
                                  ),
                                  Text(
                                    laborer.description,
                                    style: mediumWhite,
                                  ),
                                  Text(
                                    laborer.location,
                                    style: mediumWhite,
                                  ),
                                ],
                              ),
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
