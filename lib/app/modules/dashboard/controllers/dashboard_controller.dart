import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:happy_messanger/app/common/custom_dialog.dart';
import 'package:happy_messanger/app/modules/dashboard/views/dashboard_view.dart';
import 'package:happy_messanger/app/modules/home/views/home_view.dart';
import 'package:happy_messanger/app/routes/app_pages.dart';
import 'package:happy_messanger/constants/colors.dart';
import 'package:logger/logger.dart';

class DashboardController extends GetxController {
  final box = GetStorage();

  RxString displayName = ''.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  var googleAcc = Rx<GoogleSignInAccount?>(null);
  var isSignedIn = false.obs;

  User? get userProfile => auth.currentUser;

  @override
  void onInit() {
    displayName.value = userProfile != null ? userProfile!.displayName! : '';
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    // if (displayName.value != '') {
    //   Get.offAllNamed(Routes.HOME, arguments: auth.currentUser);
    // } else {
    //   Get.offAllNamed(Routes.LOGIN);
    // }
  }

  void signUp(String name, String email, String password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        displayName.value = name;
        auth.currentUser!.updateDisplayName(name);
      });

      update();
      Get.offAll(() => HomeView());
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = ('The account already exists for that email.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
          colorText: kBackgroundColor);
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
          colorText: kBackgroundColor);
    }
  }

  void signIn(String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => displayName.value = userProfile!.displayName!);

      update();
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;

      String message = '';

      if (e.code == 'wrong-password') {
        message = 'Invalid Password. Please try again!';
      } else if (e.code == 'user-not-found') {
        message =
            ('The account does not exists for $email. Create your account by signing up.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
          colorText: kBackgroundColor);
    } catch (e) {
      Get.snackbar(
        'Error occured!',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kPrimaryColor,
        colorText: kBackgroundColor,
      );
    }
  }

  // void signInWithGoogle() async {
  //   CustomFullScreenDialog.showDialog();

  //   try {
  //     googleAcc.value = await _googleSignIn.signIn();
  //     displayName.value = googleAcc.value!.displayName!;
  //     isSignedIn.value = true;

  //     update();
  //     CustomFullScreenDialog.cancelDialog();
  //     Logger().d(googleAcc.value);
  //     Get.offAllNamed(Routes.HOME, arguments: googleAcc.value);
  //   } catch (e) {
  //     CustomFullScreenDialog.cancelDialog();
  //     Logger().d(e.toString());
  //     Get.snackbar('Error occured!', e.toString(),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: kPrimaryColor,
  //         colorText: kBackgroundColor);
  //   }
  // }

  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.back();
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;

      String message = '';

      if (e.code == 'user-not-found') {
        message =
            ('The account does not exists for $email. Create your account by signing up.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
          colorText: kBackgroundColor);
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
          colorText: kBackgroundColor);
    }
  }

  void signInWithGooglee() async {
    CustomFullScreenDialog.showDialog();
    User? user;
    googleAcc.value = await _googleSignIn.signIn();

    if (googleAcc.value != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleAcc.value!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        CustomFullScreenDialog.cancelDialog();
        box.write('name', user!.displayName);
        box.write('email', user.email);
        box.write('url', user.photoURL);
        isSignedIn.value = true;
        Get.offAllNamed(Routes.HOME, arguments: user);
      } on FirebaseAuthException catch (e) {
        CustomFullScreenDialog.cancelDialog();
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
          Get.snackbar('Error Occured',
              'The account already exists with a different credential.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: kPrimaryColor,
              colorText: kBackgroundColor);
        } else if (e.code == 'invalid-credential') {
          // handle the error here                'Error occurred while accessing credentials. Try again.',
          Get.snackbar('Error Occured',
              'Error occurred while accessing credentials. Try again.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: kPrimaryColor,
              colorText: kBackgroundColor);
        }
      } catch (e) {
        Get.snackbar(
            'Error occured!', 'Error occurred using Google Sign-In. Try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: kPrimaryColor,
            colorText: kBackgroundColor);
      }
    }

    // return user;
  }

  void signout() async {
    try {
      await auth.signOut();
      await _googleSignIn.signOut();
      displayName.value = '';
      isSignedIn.value = false;
      update();
      Get.offAll(() => DashboardView());
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
          colorText: kBackgroundColor);
    }
  }
}

// // to capitalize first letter of a Sting
extension StringExtension on String {
  String capitalizeString() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
