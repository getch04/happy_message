// ignore_for_file: unnecessary_const

import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'dart:math' as math;

import 'package:get/get.dart';
import 'package:happy_messanger/app/common/text_style.dart';
import 'package:happy_messanger/constants/colors.dart';
import 'package:logger/logger.dart';

import '../controllers/message_detail_controller.dart';

class MessageDetailView extends GetView<MessageDetailController> {
  final controller = Get.put(MessageDetailController());

  final assetPath;

  final name;

  String? price = '34';

  MessageDetailView({this.assetPath, this.price, this.name});
  TextEditingController searchController = TextEditingController();

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(controller.allContacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        if (searchTermFlatten.isEmpty) {
          return false;
        }

        var phone = contact.phones.firstWhere((phn) {
          String phnFlattened = flattenPhoneNumber(phn);
          return phnFlattened.contains(searchTermFlatten);
        }, orElse: () => '');

        return phone != null;
      });
    }
    controller.contactsFiltered.value = _contacts;
    Logger().d(controller.contactsFiltered.length);
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    bool listItemsExist =
        ((isSearching == true && controller.contactsFiltered.isNotEmpty) ||
            (isSearching != true && controller.allContacts.isNotEmpty));

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        controller.selectedcount.value = 0;
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: const Color(0xFF545D68)),
            onPressed: () {
              Navigator.of(context).pop();
              controller.selectedcount.value = 0;
            },
          ),
          title: Text(name, style: textStyle18b),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search, color: kPrimaryColor),
              onPressed: () {
                filterContacts();
                isSearching = true;
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Card(
                child: Obx(() => ListTile(
                      leading: const Icon(Icons.message),
                      title: const Text('Message to send'),
                      subtitle: !controller.isEditable.value
                          ? Text(controller.title.value)
                          : TextFormField(
                              autofocus:
                                  controller.isEditable.value ? true : false,
                              initialValue: controller.title.value,
                              textInputAction: TextInputAction.done,
                              enableInteractiveSelection: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              minLines: 2,
                              maxLines: 4,
                              onFieldSubmitted: (value) {
                                controller.isEditable.value = false;
                                controller.title.value = value;
                              }),

                      // Text(
                      // 'happy new year dear happy new year dear happy new year dear happy new year dear'),
                      trailing: InkWell(
                          onTap: () {
                            controller.isEditable.value =
                                !controller.isEditable.value;
                          },
                          child: const Icon(Icons.edit)),
                    )),
              ),
              Container(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor)),
                    prefixIcon: Icon(Icons.search,
                        color: Theme.of(context).primaryColor),
                  ),
                  onChanged: (value) {
                    Logger().d(value);
                    isSearching = true;
                    filterContacts();
                  },
                ),
              ),
              Expanded(
                child: Card(
                  elevation: 0.8,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: FutureBuilder(
                    future: controller.getContacts(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                          child: const SizedBox(
                              height: 50, child: CircularProgressIndicator()),
                        );
                      } else {
                        var heyy = [];
                        for (var item in snapshot.data) {
                          if (item.displayName != '' &&
                              item.phones.isNotEmpty) {
                            heyy.add(item);
                          }
                        }

                        controller.selected.value = List.generate(heyy.length,
                            (i) => false); // Fill it with false initially
                        controller.selectedCopy =
                            controller.selected;
                        return Scrollbar(
                          isAlwaysShown: true,
                          child: ListView.builder(
                            itemCount: isSearching == true
                                ? controller.contactsFiltered.length
                                : heyy.length,
                            itemBuilder: (context, index) {
                              // Logger(index)
                              Contact contact = isSearching
                                  ? controller.contactsFiltered[index]
                                  : heyy[index];
                              return Column(children: [
                                Obx(
                                  () => isSearching &&
                                          controller.contactsFiltered.isEmpty
                                      ? const Text('no search data')
                                      : InkWell(
                                          onTap: () {
                                            controller.selectedCopy[index] =
                                                !controller.selectedCopy[index];
                                            Logger().d(
                                                controller.selectedCopy[index]);
                                            controller.selectedCopy[index] ==
                                                    true
                                                ? controller.selectedcount + 1
                                                : controller.selectedcount - 1;
                                          },
                                          child: ListTile(
                                            tileColor: controller
                                                    .selectedCopy[index]
                                                ? kPrimaryColor.withOpacity(0.1)
                                                : null,
                                            dense: true,
                                            leading: CircleAvatar(
                                              backgroundColor: Color(
                                                  (math.Random().nextDouble())
                                                      .toInt()),
                                              radius: 20,
                                              child: const Icon(Icons.person),
                                            ),
                                            title: Text(
                                              contact.displayName == ''
                                                  ? ''
                                                  : contact.displayName,
                                              style:
                                                  controller.selectedCopy[index]
                                                      ? textStyle22
                                                      : null,
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                contact.phones.isEmpty
                                                    ? const Text('')
                                                    : Text(contact.phones[0])
                                              ],
                                            ),
                                            trailing: controller
                                                    .selectedCopy[index]
                                                ? const Icon(
                                                    Icons.check_circle_outline,
                                                    color: Colors.green,
                                                  )
                                                : null,
                                          ),
                                        ),
                                ),
                                const Divider()
                              ]);
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Obx(
                () => Center(
                  child: GestureDetector(
                    onTap: () {
                      sending_SMS('', ["90"]);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 100.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: kPrimaryColor),
                      child: Center(
                        child: Text(
                          '(${controller.selectedcount.value}) send',
                          style: textStyle22w,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void sending_SMS(String msg, List<String> list_receipents) async {
    String send_result =
        await sendSMS(message: msg, recipients: list_receipents)
            .catchError((err) {
      print(err);
    });
    print(send_result);
  }
}
