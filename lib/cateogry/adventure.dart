// import 'package:e_library/screens/bookloading.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';

// class adventure extends StatefulWidget {
//   final dynamic c4;
//   adventure({@required this.c4});

//   @override
//   State<adventure> createState() => _AdventureState();
// }

// class _AdventureState extends State<adventure> {
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
//     if (widget.c4 == null || widget.c4["items"] == null) {
//       return Center(child: Text("No data available"));
//     }

//     return Container(
//       height: 270,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: widget.c4["items"].length,
//         itemBuilder: (context, index) {
//           final book = widget.c4["items"][index + 1]["volumeInfo"];
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
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return bookloading(
//                             c: book["industryIdentifiers"][0]["identifier"]);
//                       }));
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 230,
//                           width: 150,
//                           decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   spreadRadius: 3,
//                                   blurRadius: 8,
//                                   offset: Offset(2, 2))
//                             ],
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
//                               color: Colors.grey[900],
//                               fontWeight: FontWeight.bold),
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
