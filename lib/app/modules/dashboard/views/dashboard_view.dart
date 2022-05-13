import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happy_messanger/app/modules/login/views/login_view.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.displayName.value == ''
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Color.fromARGB(255, 0, 0, 0)),
                ),
                Text('Loading....')
              ],
            ))
          : LoginView()),
    );
  }
}
