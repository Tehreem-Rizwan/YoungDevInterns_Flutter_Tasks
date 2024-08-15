import 'package:e_library/Controller/BookController.dart';
import 'package:e_library/Pages/AddNewBook/AddNewBook.dart';
import 'package:e_library/components/BookTile.dart';
import 'package:e_library/components/MyDrawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatelessWidget {
  final String userRole = 'Admin';

  @override
  Widget build(BuildContext context) {
    BookController bookController = Get.put(BookController());

    return Scaffold(
      drawer: myDrawer(context, userRole),
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 100, 211, 150),
      ),
      backgroundColor: Color.fromARGB(255, 100, 211, 150),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, Admin!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "All Books",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            SizedBox(height: 20),
                            Obx(() {
                              if (bookController.bookData.isEmpty) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return Column(
                                  children: bookController.bookData
                                      .map((e) => BookTile(
                                            title: e.title!,
                                            coverUrl: e.coverUrl!,
                                            author: e.author!,
                                            ontap: () {},
                                          ))
                                      .toList(),
                                );
                              }
                            })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.to(() => AddNewBookPage());
                },
                icon: Icon(
                  Icons.add,
                  color: Color.fromARGB(255, 100, 211, 150),
                  size: 25,
                ),
                label: Text(
                  'Add New Book',
                  style: TextStyle(color: Color.fromARGB(255, 100, 211, 150)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
