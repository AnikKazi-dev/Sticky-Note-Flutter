import 'package:flutter/material.dart';
import 'package:sticky_notes/db/notes_database.dart';
import 'package:sticky_notes/model/note.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  String? title;
  String? description;
  DateTime? date;

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  addNote(Note note) {
    NotesDatabase.instance.create(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.6),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Note Title",
              ),
              style: TextStyle(fontSize: 28.9, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: TextField(
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Your note",
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            title = titleController.text;
            description = bodyController.text;
            date = DateTime.now();
          });
          Note note = Note(
            isImportant: true,
            number: 2121,
            title: title.toString(),
            description: description.toString(),
            time: DateTime.now(),
          );
          //Note note =NoteModel(title: title, body: body, creation_date: date);
          addNote(note);
          Navigator.of(context).pop();
        },
        label: Text("Save Note"),
        icon: Icon(Icons.save),
      ),
    );
  }
}
