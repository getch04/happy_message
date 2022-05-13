import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:happy_messanger/constants/colors.dart';

class CustomCircularButton extends StatelessWidget {
  const CustomCircularButton({
    Key? key,
    required this.onPressed,
    required this.flatIcon,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String flatIcon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 15,
        padding: const EdgeInsets.all(15),
        primary: AppColors.whiteColor,
        shadowColor: AppColors.blackColor,
        shape: const CircleBorder(),
      ),
      child: Image.asset(
        flatIcon,
        height: 20,
      ),
      // color: AppColors.blackColor,
      // size: 15,
    );
  }
}
