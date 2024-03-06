import "package:flutter/material.dart";
import "package:isar/isar.dart";
import "package:mitchkoko_notes/models/note.dart";
import "package:path_provider/path_provider.dart";

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  // Initialize
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  final List<Note> currentNotes = [];
  // Create

  Future<void> addNote(String textNote) async {
    final newNote = Note()..text = textNote;
    await isar.writeTxn(() => isar.notes.put(newNote));

    fetchNotes();
  }

  // Read
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  // Update
  Future<void> updateNote(int id, String newNote) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newNote;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  // Delete
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}
