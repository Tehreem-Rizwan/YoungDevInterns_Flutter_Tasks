import 'package:e_library/models/NoteModel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'NotesListPage.dart'; // import the new screen

class NotesBookPage extends StatefulWidget {
  @override
  _NotesBookPageState createState() => _NotesBookPageState();
}

class _NotesBookPageState extends State<NotesBookPage> {
  final TextEditingController _bookTitleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final CollectionReference notesCollection =
      FirebaseFirestore.instance.collection('notes');

  Future<void> _addNote() async {
    if (_bookTitleController.text.isNotEmpty &&
        _contentController.text.isNotEmpty) {
      Note newNote = Note(
        id: notesCollection.doc().id,
        bookTitle: _bookTitleController.text,
        content: _contentController.text,
        timestamp: DateTime.now(),
      );

      await notesCollection.doc(newNote.id).set(newNote.toMap());

      _bookTitleController.clear();
      _contentController.clear();

      // Navigate to the NotesListPage after adding the note
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotesListPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes Book',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _bookTitleController,
              decoration: InputDecoration(
                labelText: 'Book Title',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Note Content',
              ),
              maxLines: 1,
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: _addNote,
              child: Text(
                'Add Note',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
