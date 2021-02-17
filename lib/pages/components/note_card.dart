import 'package:flutter/material.dart';
import 'package:nalandha/pages/constants.dart';
import 'package:nalandha/pages/models/Note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final Function onPressed;

  NoteCard({this.note, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: kLargeMargin, vertical: kSmallMargin),
        child: ListTile(
          title: Text(note.title),
          subtitle: Text(note.note),
        ),
      ),
    );
  }
}
