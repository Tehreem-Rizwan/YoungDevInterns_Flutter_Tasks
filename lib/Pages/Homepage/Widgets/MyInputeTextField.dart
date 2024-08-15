import 'package:e_library/Controller/BookController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MyInputTextField extends StatelessWidget {
  const MyInputTextField(
      {super.key, required String hintText, required IconData icon});

  @override
  Widget build(BuildContext context) {
    BookController bookController = Get.put(BookController());
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.background,
      ),
      child: Row(
        children: [
          SizedBox(width: 20),
          InkWell(
              onTap: () {
                bookController.getAllBooks();
              },
              child: SvgPicture.asset("assets/Icons/search.svg")),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Search here . .",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
