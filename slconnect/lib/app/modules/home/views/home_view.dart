import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:slconnect/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.gif"),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("SL Connect",
                      style: TextStyle(
                        fontSize: 24,
                      )),
                  Lottie.asset("assets/lottie/signuplady.json"),
                  Text("Sign Up",
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
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2)),
                          prefixIcon: Icon(Icons.call),
                          labelText: "Phone Number",
                          floatingLabelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              backgroundColor: Theme.of(context).cardColor)),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => Get.toNamed(Routes.LOGIN),
                      child: Text("Submit"))
                ],
              ),
            )));
  }
}
