import 'package:flutter/material.dart';
import 'package:mitchkoko_notes/models/note_database.dart';
import 'package:mitchkoko_notes/pages/notes_page.dart';
import 'package:mitchkoko_notes/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => NoteDatabase()),
    ChangeNotifierProvider(create: (context) => ThemeProvider())
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotesPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
