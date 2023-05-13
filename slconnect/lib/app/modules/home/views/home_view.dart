import 'package:flutter/material.dart';

import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slconnect/app/routes/app_pages.dart';
import 'package:slconnect/app/widgets/BottomNavigation.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return GetBuilder<HomeController>(
        builder: (_) => Scaffold(
            bottomNavigationBar: const BottomNavigation(
              currentIndex: 0,
            ),
            body: SingleChildScrollView(
              reverse: true,
              physics: const BouncingScrollPhysics(),
              child: Container(
                  height: screenHeight,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/background.gif"),
                          fit: BoxFit.cover)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Home Page",
                            style: TextStyle(
                              fontSize: 24,
                            )),
                        // Lottie.asset("assets/lottie/signuplady.json"),
                        Text("Signed In Successfully",
                            style: TextStyle(
                              fontSize: 24,
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        width: 2)),
                                prefixIcon: Icon(Icons.call),
                                labelText: "Phone Number",
                                floatingLabelStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    backgroundColor:
                                        Theme.of(context).cardColor)),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.remove('phone');
                              Get.offAndToNamed(Routes.LOGIN);
                            },
                            child: const Text("Don't Click"))
                      ],
                    ),
                  )),
            )));
  }
}
