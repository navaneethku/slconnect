import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:slconnect/app/routes/app_pages.dart';
import 'package:slconnect/consts/colors.dart';
import 'package:slconnect/consts/common_styles.dart';
import 'package:slconnect/firebase/db.dart';

import '../../../models/LaborerModel.dart';
import '../controllers/category_detailed_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class CategoryDetailedView extends GetView<CategoryDetailedController> {
  const CategoryDetailedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments.toString()),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Container(height: 200, width: 300, child: UserSearchScreen()),
          FutureBuilder(
            future: DatabaseService().getLaborersByCategory(Get.arguments),
            builder: (BuildContext context,
                AsyncSnapshot<List<LaborerModel?>> snapshot) {
              int laborerListLength = snapshot.data?.length ?? 0;
              if (snapshot.hasData) {
                return Expanded(
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
                                        color: index % 2 == 0
                                            ? secondary
                                            : primary,
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
                                      width: double.maxFinite,
                                      color:
                                          index % 2 == 0 ? primary : secondary,
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
                                            Align(
                                              alignment: Alignment.center,
                                              child: MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                color:
                                                    Theme.of(context).cardColor,
                                                onPressed: () {
                                                  Get.toNamed(
                                                      Routes.PROFILE_LABORER,
                                                      arguments: [
                                                        laborer,
                                                        controller
                                                            .laborerCurrentSkill
                                                      ]);
                                                },
                                                child:
                                                    const Text("Check Profile"),
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
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

// class UserSearchScreen extends StatefulWidget {
//   @override
//   _UserSearchScreenState createState() => _UserSearchScreenState();
// }

// class _UserSearchScreenState extends State<UserSearchScreen> {
//   TextEditingController _searchController = TextEditingController();
//   GlobalKey<AutoCompleteTextFieldState<String>> _searchKey =
//       GlobalKey<AutoCompleteTextFieldState<String>>();
//   List<String> _suggestions = [];
//   List<DocumentSnapshot> _searchResults = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadLocations();
//   }

//   Future<void> _loadLocations() async {
//     var collectionReference = FirebaseFirestore.instance.collection('users');

//     QuerySnapshot querySnapshot = await collectionReference
//         .where("location", isEqualTo: Get.arguments.toString())
//         .get();

//     List<String> locations = [];
//     querySnapshot.docs.forEach((doc) {
//       String location = doc['location'];
//       if (!locations.contains(location)) {
//         locations.add(location);
//       }
//     });

//     setState(() {
//       _suggestions = locations;
//     });
//   }

//   Future<void> _searchUsers(String searchLocation) async {
//     var collectionReference = FirebaseFirestore.instance.collection('users');

//     QuerySnapshot querySnapshot = await collectionReference
//         .where('skill', arrayContains: Get.arguments.toString())
//         .where('location', isEqualTo: searchLocation)
//         .get();

//     setState(() {
//       _searchResults = querySnapshot.docs;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     AutoCompleteTextField<String> _searchTextField =
//         AutoCompleteTextField<String>(
//       key: _searchKey,
//       controller: _searchController,
//       suggestions: _suggestions,
//       clearOnSubmit: false,
//       decoration: InputDecoration(
//         labelText: 'Search Location',
//         suffixIcon: IconButton(
//           icon: Icon(Icons.search),
//           onPressed: () {
//             String searchLocation = _searchController.text.trim();
//             _searchUsers(searchLocation);
//           },
//         ),
//       ),
//       itemSubmitted: (item) {
//         _searchController.text = item;
//       },
//       itemBuilder: (context, item) {
//         return ListTile(
//           title: Text(item),
//         );
//       },
//       itemSorter: (a, b) {
//         return a.compareTo(b);
//       },
//       itemFilter: (item, query) {
//         return item.toLowerCase().startsWith(query.toLowerCase());
//       },
//     );

//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: _searchTextField,
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _searchResults.length,
//               itemBuilder: (context, index) {
//                 DocumentSnapshot document = _searchResults[index];
//                 return ListTile(
//                   title: Text(document['name']),
//                   subtitle: Text(document['location']),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
