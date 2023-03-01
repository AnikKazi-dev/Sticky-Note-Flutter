import 'package:flutter/material.dart';

import '../db/notes_database.dart';
import '../model/note.dart';

class EditNoteScreen extends StatefulWidget {
  final Note note;
  EditNoteScreen(this.note);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  String? title;
  String? description;
  DateTime? date;

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  updateNote() async {
    final tempNote = widget.note.copy(
      //isImportant: isImportant,
      //number: number,
      title: title,
      description: description,
      time: date,
    );
    await NotesDatabase.instance.update(tempNote);
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.note.title;
    bodyController.text = widget.note.description;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.6),
        child: Column(
          children: [
            TextField(
              controller: titleController..text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Note Title",
              ),
              style: TextStyle(fontSize: 28.9, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: TextField(
                controller: bodyController..text,
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
          updateNote();
          Navigator.of(context).pop();
        },
        label: Text("Save Note"),
        icon: Icon(Icons.save),
      ),
    );
  }
}
