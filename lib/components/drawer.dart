import "package:flutter/material.dart";
import "package:mitchkoko_notes/components/drawer_tile.dart";
import "package:mitchkoko_notes/pages/settings.dart";

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            DrawerHeader(child: Icon(Icons.note)),
            DrawerTile(
                title: "Notes",
                leading: Icon(Icons.home),
                onTap: () => Navigator.pop(context)),
            DrawerTile(
                title: "Settings",
                leading: Icon(Icons.settings),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                }),
          ],
        ));
  }
}