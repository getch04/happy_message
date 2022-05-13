// ignore_for_file: unnecessary_const, prefer_const_constructors

import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:happy_messanger/constants/colors.dart';
import '../controllers/contacts_controller.dart';

enum SlidableActions { message, call }

class ContactsView extends GetView<ContactsController> {
  TextEditingController msgcontroller = TextEditingController();
  @override
  var controller = Get.put(ContactsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Your Contacts"),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: FutureBuilder(
            future: controller.getContacts(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child:
                      SizedBox(height: 50, child: CircularProgressIndicator()),
                );
              } else {
                var heyy = [];
                for (var item in snapshot.data) {
                  if (item.displayName != '' && item.phones.isNotEmpty) {
                    heyy.add(item);
                    controller.contactList.add(item);
                  }
                }
                return ListView.builder(
                  itemCount: heyy.length,
                  itemBuilder: (context, index) {
                    Contact contact = heyy[index];
                    return Slidable(
                      key: const ValueKey(0),

                      // The start action pane is the one at the left or the top side.
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            backgroundColor:
                                const Color.fromARGB(255, 202, 0, 141),
                            foregroundColor: Colors.white,
                            icon: Icons.call,
                            label: 'Call',
                            onPressed: (BuildContext context) => onDismissed(
                                context,
                                index,
                                SlidableActions.call,
                                contact.phones[0]),
                          ),
                          SlidableAction(
                            onPressed: (BuildContext context) => onDismissed(
                                context,
                                index,
                                SlidableActions.message,
                                contact.phones[0]),
                            backgroundColor: const Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.message,
                            label: 'Message',
                          ),
                        ],
                      ),

                      child: Column(
                        children: [
                          ListTile(
                            dense: true,
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color((math.Random().nextDouble()).toInt()),
                              radius: 20,
                              child: const Icon(Icons.person),
                            ),
                            title: Text(contact.displayName == ''
                                ? ''
                                : contact.displayName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                contact.phones.isEmpty
                                    ? const Text('')
                                    : Text(contact.phones[0])
                              ],
                            ),
                          ),
                          const Divider()
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    
    );
  }

  onDismissed(context, int index, SlidableActions action, String phone) async {
    switch (action) {
      case SlidableActions.call:
        return await FlutterPhoneDirectCaller.callNumber(phone);
      case SlidableActions.message:
        await showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20.0))),
            backgroundColor: Colors.white,
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return messageSent(context, phone);
            });
        break;
      default:
    }
  }

  Widget messageSent(context, phone) {
    return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          child: SingleChildScrollView(
            child: Form(
              // key: _formKey,
              // autovalidateMode: autoValidate,
              child: Column(children: [
                Text(
                  'Message'.tr,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(
                  width: 15,
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    controller: msgcontroller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'message'.tr,
                        hintText: 'write here...'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('Cancel'.tr),
                    ),
                    GestureDetector(
                      onTap: () {
                        sending_SMS(msgcontroller.text, [phone]);
                      },
                      child: Container(
                        width: 150,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: kPrimaryColor,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              // Icon(
                              //   Icons.send,
                              //   color: Colors.white,
                              // ),
                              Text(
                                'send',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ]),
            ),
          ),
        ));
  }

  Future<dynamic> sheet(context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Flexible(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text(
                  'Message',
                  style: TextStyle(
                    color: Color.fromARGB(255, 5, 5, 5),
                    fontSize: 22,
                    fontFamily: 'AkayaTelivigala',
                  ),
                ),
                Expanded(
                    child: TextFormField(
                  minLines: 2,
                  maxLines: 7,
                )),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 50,
                    width: 30,
                    decoration: const BoxDecoration(
                        color: Colors.pink, shape: BoxShape.circle),
                    child: const Icon(Icons.add_card_rounded),
                  ),
                ),
                SizedBox(
                  height: 270,
                )
              ],
            ),
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
