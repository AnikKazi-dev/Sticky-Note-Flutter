import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sticky_notes/Screens/add_note_screen.dart';
import 'package:sticky_notes/Screens/note_detail_screen.dart';
import 'package:sticky_notes/db/notes_database.dart';
import 'package:sticky_notes/model/note.dart';
import 'package:sticky_notes/widgets/note_tile.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late List<Note> notes;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() {
      isLoading = true;
    });
    this.notes = await NotesDatabase.instance.readAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes",
          style: TextStyle(fontSize: 24),
        ),
        actions: const [Icon(Icons.search), SizedBox(width: 12)],
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : notes.isEmpty
                ? const Text(
                    "No Notes",
                    style: TextStyle(color: Colors.white),
                  )
                : MasonryGridView.count(
                    padding: EdgeInsets.all(8),
                    itemCount: notes.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    itemBuilder: (context, index) {
                      return //NoteTile(notes[index], index);
                          GestureDetector(
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  NoteDetailScreen(noteId: notes[index].id!),
                            ),
                          );
                          refreshNotes();
                        },
                        child: NoteTile(notes[index], index),
                      );
                    },
                  ),
        
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddNoteScreen()),
          );
          refreshNotes();
        },
      ),
    );
  }
}
