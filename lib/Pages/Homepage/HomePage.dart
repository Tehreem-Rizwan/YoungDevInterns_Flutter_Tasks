import 'package:e_library/Controller/BookController.dart';
import 'package:e_library/Pages/BookDetails/BookDetails.dart';
import 'package:e_library/Pages/Homepage/Widgets/MyInputeTextField.dart';
import 'package:e_library/Pages/Homepage/notesbook/NotesListPage.dart';
import 'package:e_library/components/BookCard.dart';
import 'package:e_library/components/BookTile.dart';
import 'package:e_library/components/MyDrawer.dart';
import 'package:e_library/models/Data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String userRole = "User"; // Define userRole within the class
  int _selectedIndex = 0; // Track the selected index of BottomNavigationBar

  final List<Widget> _pages = [
    HomeContent(), // Create a separate widget for the home content
    NotesListPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(context, userRole),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 100, 211, 150),
        title: Text(
          "E-LIBRARY",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BookController bookController = Get.put(BookController());
    bookController.getUserBook();

    final bookData = bookController.bookData ?? [];

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Welcome to E-Library",
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "Time to explore new books and broaden your horizons!",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                MyInputTextField(
                  hintText: "Search for books, authors, genres...",
                  icon: Icons.search,
                ),
                SizedBox(height: 20),
                Row(
                  children: [],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Trending Books",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(
                    () => Row(
                      children: bookData.isNotEmpty
                          ? bookData
                              .map(
                                (e) => BookCard(
                                  title: e.title ?? "Unknown Title",
                                  coverUrl: e.coverUrl ?? "default_cover_url",
                                  ontap: () {
                                    Get.to(BookDetails(book: e));
                                  },
                                ),
                              )
                              .toList()
                          : [Text("No books available")],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Recommended Books",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Obx(
                  () => Column(
                    children: bookData.isNotEmpty
                        ? bookData
                            .map(
                              (e) => BookTile(
                                ontap: () {
                                  Get.to(BookDetails(book: e));
                                },
                                title: e.title ?? "Unknown Title",
                                coverUrl: e.coverUrl ?? "default_cover_url",
                                author: e.author ?? "Unknown Author",
                              ),
                            )
                            .toList()
                        : [Text("No recommendations available")],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
