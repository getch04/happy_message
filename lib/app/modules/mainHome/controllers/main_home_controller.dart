import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:happy_messanger/app/data/localization.dart';
import 'package:happy_messanger/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:logger/logger.dart';

class MainHomeController extends GetxController {
  DashboardController homeController = Get.find<DashboardController>();
  final box = GetStorage();
  User? user;
  String? username;
  String? email;
  String? url;

  RxBool isAmharic = false.obs;
  GetStorage cc = GetStorage();
  var langCtrl = Get.put(LocaleString());

  @override
  void onInit() async {
    super.onInit();
    // user = Get.arguments;
    username = box.read('name');
    email = box.read('email');
    url = box.read('url');

    Logger().d(username);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void logout() async {
    // await homeController.googleSign!.disconnect();
    // await homeController.firebaseAuth.signOut();
  }
}
