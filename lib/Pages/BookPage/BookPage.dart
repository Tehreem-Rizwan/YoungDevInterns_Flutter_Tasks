import 'package:e_library/Controller/PdfController.dart';
import 'package:e_library/Pages/Homepage/notesbook/NotesPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class BookPage extends StatelessWidget {
  final String bookUrl;
  final String bookTitle;

  const BookPage({
    super.key,
    required this.bookUrl,
    required this.bookTitle,
  });

  Future<String> downloadPDF(String url, {String? fileName}) async {
    final response = await http.get(Uri.parse(url));

    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
    }

    final directory = await getExternalStorageDirectory();
    final filePath = '${directory!.path}/${fileName ?? 'downloaded_book'}.pdf';
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    PdfController pdfController = Get.put(PdfController());

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Theme.of(context).colorScheme.background,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          bookTitle,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Theme.of(context).colorScheme.background),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.download,
              color: Colors.white,
            ),
            onPressed: () async {
              final filePath = await downloadPDF(bookUrl, fileName: bookTitle);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("PDF downloaded to $filePath"),
              ));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.note_add, // Icon for the notebook
              color: Colors.white,
            ),
            onPressed: () {
              // Navigate to the NotebookScreen when the button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      NotesBookPage(), // Navigate to NotesBookPage
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<String>(
        future: downloadPDF(bookUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return PDFView(
              filePath: snapshot.data,
              onRender: (pages) => pdfController.totalPages.value = pages!,
              onViewCreated: (controller) =>
                  pdfController.pdfController = controller,
              onPageChanged: (page, _) =>
                  pdfController.currentPage.value = page!,
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading PDF"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
