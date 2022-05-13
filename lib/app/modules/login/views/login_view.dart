import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happy_messanger/app/common/custom_circular_button.dart';
import 'package:happy_messanger/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:happy_messanger/app/modules/home/views/home_view.dart';
import 'package:happy_messanger/constants/colors.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  var vcontroller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage(
                        'assets/images/t.png',
                      ),
                    ),
                    // Container(
                    //   height: MediaQuery.of(context).size.height * 0.421,
                    //   width: MediaQuery.of(context).size.width,
                    //   foregroundDecoration: const BoxDecoration(
                    //     image: DecorationImage(
                    //       image: AssetImage(
                    //         'assets/images/t.png',
                    //       ),
                    //     ),
                    //   ),
                    //   alignment: Alignment.bottomCenter,
                    //   padding: const EdgeInsets.only(bottom: 20),
                    //   child: const Text(
                    //     "'",
                    //   ),
                    // ),
                    const Text(
                        'welcome to happy message app welcome to happy message app',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'AkayaTelivigala',
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // TextField(
                          //   // textAlign: TextAlign.center,
                          //   // controller: searchCtrl,
                          //   keyboardType: TextInputType.text,
                          //   decoration: InputDecoration(
                          //     hintText: 'Enter your name....',
                          //     hintStyle: const TextStyle(
                          //       fontSize: 16,
                          //       fontFamily: 'AkayaTelivigala',
                          //     ),
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(35),
                          //       borderSide: const BorderSide(
                          //         width: 0,
                          //         style: BorderStyle.none,
                          //       ),
                          //     ),
                          //     filled: true,
                          //     contentPadding: const EdgeInsets.all(20),
                          //     // fillColor: colorSearchBg,
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Material(
                              color: const Color.fromARGB(255, 111, 161, 248),
                              borderRadius: BorderRadius.circular(15),
                              child: InkWell(
                                hoverColor: Colors.orange,
                                splashColor:
                                    const Color.fromARGB(255, 9, 255, 0),
                                focusColor: Colors.yellow,
                                highlightColor: Colors.purple,
                                onTap: () {
                                  Get.to(() => HomeView());
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Get Started',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'AkayaTelivigala',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     // CustomCircularButton(
                          //     //   onPressed: () => vcontroller.signInWithGooglee(),
                          //     //   flatIcon: 'assets/images/google.png',
                          //     // ),
                          //     // CustomCircularButton(
                          //     //   onPressed: () {},
                          //     //   flatIcon: 'assets/images/facebook.png',
                          //     // ),
                          //     // CustomCircularButton(
                          //     //   onPressed: () {},
                          //     //   flatIcon: 'assets/images/google.png',
                          //     // ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
