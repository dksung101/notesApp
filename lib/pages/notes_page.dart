import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitchkoko_notes/components/drawer.dart';
import 'package:mitchkoko_notes/components/note_tile.dart';
import 'package:mitchkoko_notes/models/note.dart';
import 'package:mitchkoko_notes/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => NotesPageState();
}

class NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readNotes();
  }

  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                  controller: textController,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontFamily: 'Brockmann'),
                  cursorColor: Theme.of(context).colorScheme.inversePrimary,
                  decoration: InputDecoration(
                    hintText: "Enter your note",
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).colorScheme.inversePrimary)),
                  )),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                        textController.clear();
                      },
                      child: Text("Back"),
                    ),
                    MaterialButton(
                      onPressed: () {
                        context
                            .read<NoteDatabase>()
                            .addNote(textController.text);
                        Navigator.pop(context);
                        textController.clear();
                      },
                      child: Text('Create'),
                    )
                  ],
                )
              ],
            ));
  }

  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Update Note"),
              content: TextField(
                  controller: textController,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontFamily: 'Brockmann'),
                  cursorColor: Theme.of(context).colorScheme.inversePrimary,
                  decoration: InputDecoration(
                    hintText: "Update note",
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).colorScheme.inversePrimary)),
                  )),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                          textController.clear();
                        },
                        child: Text("Cancel")),
                    MaterialButton(
                      onPressed: () {
                        context
                            .read<NoteDatabase>()
                            .updateNote(note.id, textController.text);
                        textController.clear();

                        Navigator.pop(context);
                      },
                      child: Text("Update"),
                    )
                  ],
                )
              ],
            ));
  }

  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();

    List<Note> currentNotes = noteDatabase.currentNotes;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: FloatingActionButton(
          onPressed: createNote,
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        drawer: const MyDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Notes',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontFamily: 'Geomanist',
                    fontSize: 48,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: currentNotes.length,
                  itemBuilder: (context, index) {
                    final note = currentNotes[index];
                    return NoteTile(
                        title: (index + 1).toString() + '. ' + note.text,
                        onEditPressed: () => updateNote(note),
                        onDeletePressed: () => deleteNote(note.id));
                  }),
            ),
          ],
        ));
  }
}
