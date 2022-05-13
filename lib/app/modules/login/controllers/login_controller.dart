import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:happy_messanger/app/common/custom_dialog.dart';
import 'package:happy_messanger/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:happy_messanger/app/modules/home/controllers/home_controller.dart';

class LoginController extends GetxController {
  DashboardController homeController = Get.find<DashboardController>();
  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

 
}
