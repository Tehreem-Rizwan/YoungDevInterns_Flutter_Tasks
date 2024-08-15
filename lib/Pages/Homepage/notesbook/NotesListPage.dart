import 'package:e_library/Pages/Homepage/notesbook/NotesPage.dart';
import 'package:e_library/models/NoteModel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotesListPage extends StatelessWidget {
  final CollectionReference notesCollection =
      FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Notes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            notesCollection.orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final notes = snapshot.data!.docs
              .map((doc) => Note.fromMap(doc.data() as Map<String, dynamic>))
              .toList();

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return ListTile(
                title: Text(note.bookTitle),
                subtitle: Text(note.content),
                trailing: Text(
                  note.timestamp.toLocal().toString().substring(0, 16),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the NotesPageScreen when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotesBookPage()),
          );
        },
        child: Icon(Icons.add), // Add icon for the FAB
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
