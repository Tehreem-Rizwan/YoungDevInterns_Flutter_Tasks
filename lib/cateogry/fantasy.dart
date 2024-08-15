// import 'package:e_library/screens/bookloading.dart';
// import 'package:e_library/screens/error.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';

// class fantasy extends StatefulWidget {
//   final dynamic c2;
//   fantasy({@required this.c2});

//   @override
//   State<fantasy> createState() => _FantasyState();
// }

// class _FantasyState extends State<fantasy> {
//   String st(String s) {
//     int count = 0;
//     String ans = "";
//     for (int i = 0; i < s.length; i++) {
//       if (count == 3) {
//         break;
//       }
//       if (s[i] == ' ') {
//         count++;
//       }
//       ans = ans + s[i];
//     }
//     return ans + "...";
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.c2 == null || widget.c2["items"] == null) {
//       return Center(child: Text("No data available"));
//     }

//     return Container(
//       height: 270,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: widget.c2["items"].length,
//         itemBuilder: (context, index) {
//           if (index + 1 >= widget.c2["items"].length) {
//             return SizedBox(); // Avoid IndexError
//           }

//           final book = widget.c2["items"][index + 1]["volumeInfo"];
//           final imageUrl =
//               book["imageLinks"]?["thumbnail"] ?? 'default_image_url';
//           final title = book["title"] ?? "No title";

//           return Container(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                   child: GestureDetector(
//                     onTap: () {
//                       try {
//                         final identifier =
//                             book["industryIdentifiers"]?[0]["identifier"];
//                         if (identifier != null) {
//                           Navigator.push(context,
//                               MaterialPageRoute(builder: (context) {
//                             return bookloading(c: identifier);
//                           }));
//                         } else {
//                           throw Exception("Identifier not found");
//                         }
//                       } catch (e) {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return error();
//                         }));
//                       }
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 230,
//                           width: 150,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             image: DecorationImage(
//                               image: NetworkImage(imageUrl),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           title.length > 20 ? st(title) : title,
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.grey[900]),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
