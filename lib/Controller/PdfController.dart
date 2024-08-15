import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

class PdfController extends GetxController {
  RxInt currentPage = 0.obs;
  RxInt totalPages = 0.obs;
  PDFViewController? pdfController;
}
