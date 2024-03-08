import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  final String title;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;

  const NoteTile({
    super.key,
    required this.title,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.only(top: 10, left: 25, right: 25),
        child: ListTile(
            title: Text(
              title,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontFamily: 'Brockmann'),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onEditPressed,
                  icon: Icon(Icons.edit),
                  splashRadius: 25,
                ),
                IconButton(
                  onPressed: onDeletePressed,
                  icon: Icon(Icons.delete),
                  splashRadius: 25,
                ),
              ],
            )));
  }
}
