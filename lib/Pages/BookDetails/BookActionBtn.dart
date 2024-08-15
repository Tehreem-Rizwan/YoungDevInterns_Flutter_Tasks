import 'package:e_library/Pages/BookPage/BookPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BookActionBtn extends StatelessWidget {
  final String bookUrl;
  final String bookTitle;
  const BookActionBtn(
      {super.key, required this.bookUrl, required this.bookTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.to(BookPage(
                bookUrl: bookUrl,
                bookTitle: bookTitle,
              ));
            },
            child: Row(
              children: [
                SvgPicture.asset("assets/Icons/book.svg"),
                SizedBox(width: 10),
                Text(
                  "READ BOOK",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.background,
                        letterSpacing: 1.2,
                      ),
                ),
              ],
            ),
          ),
          Container(
            width: 3,
            height: 30,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
