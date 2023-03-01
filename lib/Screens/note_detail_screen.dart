import 'package:flutter/material.dart';
import 'package:sticky_notes/Screens/edit_note_screen.dart';
import 'package:sticky_notes/db/notes_database.dart';
import 'package:sticky_notes/model/note.dart';
import 'package:intl/intl.dart';

class NoteDetailScreen extends StatefulWidget {
  final int noteId;
  NoteDetailScreen({required this.noteId});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late Note note;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    refreshNote();
  }

  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });
    this.note = await NotesDatabase.instance.readNote(widget.noteId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [editButton(), deleteButton()],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(12),
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 8),
                children: [
                  Text(
                    note.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    DateFormat.yMMMd().format(note.time),
                    style: TextStyle(color: Colors.black38),
                  ),
                  SizedBox(height: 8),
                  Text(
                    note.description,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  )
                ],
              ),
            ),
    );
  }

  Widget editButton() => IconButton(
        icon: Icon(Icons.edit_outlined),
        onPressed: () async {
          if (isLoading) return;
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditNoteScreen(note),
            ),
          );

          refreshNote();
        },
      );
  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await NotesDatabase.instance.delete(widget.noteId);
          Navigator.of(context).pop();
        },
      );
}
