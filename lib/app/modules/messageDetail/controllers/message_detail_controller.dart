import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_messanger/app/modules/contacts/contacts_model.dart';
import 'package:permission_handler/permission_handler.dart';

class MessageDetailController extends GetxController {
  //TODO: Implement MessageDetailController

  final checked = false.obs;
  var selectedContacts = [].obs;
  RxBool toogle = false.obs;
  var selectedcount = 0.obs;
  List<Contact> allContacts = <Contact>[].obs;
  RxList<String> selectedPhone = <String>[].obs;

  RxList<bool> selected = <bool>[].obs;
  RxList<Contact> contactsFiltered = <Contact>[].obs;

  // RxString title = "MyTitle".obs;
  RxBool isEditable = false.obs;

  RxList<AppContact>? xx = <AppContact>[].obs;

  @override
  void onInit() {
    selectedPhone.clear();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  onClose() {}

  Future<List<Contact>> getContacts() async {
    bool isGranted = await Permission.contacts.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.contacts.request().isGranted;
    }
    if (isGranted) {
      allContacts = await FastContacts.allContacts;
      return allContacts;
    }

    return [];
  }
}
