import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nalandha/pages/components/notes_stream.dart';
import 'package:nalandha/pages/screens/note_screen.dart';

class NotesScreen extends StatelessWidget {
  bool indexTab;
  NotesScreen({this.indexTab});
  static final String routeName = '/';
  final Firestore _firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text('Notes',
          style: TextStyle(
            color: Colors.black,
            fontFamily: "tepeno",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[NotesStream(firestore: _firestore)],
      ),
      floatingActionButton: indexTab==true ? FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NoteScreen.routeName);
        },
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ):null,
    );
  }
}
