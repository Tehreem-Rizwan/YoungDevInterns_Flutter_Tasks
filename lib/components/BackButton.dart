import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/Icons/back.svg",
            color: Colors.white,
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
