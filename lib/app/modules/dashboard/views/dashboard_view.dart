import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happy_messanger/app/modules/home/views/home_view.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.49,
                      width: MediaQuery.of(context).size.width,
                      foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/dash.png',
                            ),
                            fit: BoxFit.contain),
                      ),
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.only(bottom: 20),
                      child: const Text(
                        "'",
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: Text('Your Name',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'AkayaTelivigala',
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextField(
                          // textAlign: TextAlign.center,
                          // controller: searchCtrl,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Enter your name....',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'AkayaTelivigala',
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            contentPadding: EdgeInsets.all(20),
                            // fillColor: colorSearchBg,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Material(
                            color: Colors.lightGreenAccent,
                            borderRadius: BorderRadius.circular(15),
                            child: InkWell(
                              hoverColor: Colors.orange,
                              splashColor: Color.fromARGB(255, 9, 255, 0),
                              focusColor: Colors.yellow,
                              highlightColor: Colors.purple,
                              onTap: () {
                                Get.to(() => HomeView());
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Get Started',
                                  style: TextStyle(
                                    // color: Colors.white,
                                    fontSize: 22,
                                    fontFamily: 'AkayaTelivigala',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              //<-- SEE HERE
              left: 10,
              top: 100,
              child: Container(
                width: 150,
                height: 70,
                color: Color(0xFF1F3053),
                child: const Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontFamily: 'AkayaTelivigala',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
