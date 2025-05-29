import 'package:flutter/material.dart';
import 'package:guruh3/models/note.dart';
import 'package:hive/hive.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final Box<Note> noteBox = Hive.box('noteBox');

  void addNote() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Note'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('title'),
                SizedBox(height: 8.0),
                TextField(controller: titleController),
                SizedBox(height: 16.0),
                Text('content'),
                SizedBox(height: 8.0),
                TextField(controller: contentController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    contentController.text.isNotEmpty) {
                  final note = Note(
                    title: titleController.text,
                    content: contentController.text,
                  );
                  noteBox.add(note);
                  setState(() {});
                  Navigator.pop(context);
                }
              },
              style: TextButton.styleFrom(foregroundColor: Colors.blue),
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
      ),
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: noteBox.isEmpty
          ? Center(
              child: Text('Note qo\'shilmadi'),
            )
          : ListView.builder(
              itemCount: noteBox.length,
              itemBuilder: (context, index) {
                final note = noteBox.getAt(index);
                return ListTile(
                  title: Text(note!.title),
                  subtitle: Text(note.content),
                );
              },
            ),
    );
  }
}
