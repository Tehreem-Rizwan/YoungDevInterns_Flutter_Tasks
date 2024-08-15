import 'package:e_library/Controller/BookController.dart';
import 'package:e_library/Controller/SplaceController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplacePage extends StatelessWidget {
  const SplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    SplaceController splaceController = Get.put(SplaceController());
    BookController bookController = Get.put(BookController());

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Lottie.asset("assets/Animation/Anim2.json"),
      ),
    );
  }
}
