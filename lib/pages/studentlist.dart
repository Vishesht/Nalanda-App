import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nalandha/pages/classroom.dart';

class StudentList extends StatelessWidget {
  String uid;
  StudentList({this.uid});
  var taskcollections = Firestore.instance.collection('tasks');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text(" Your Students"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: taskcollections
            .document(uid)
            .collection('students')
            .orderBy('time')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];

                return Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      'abc',
                      style: TextStyle(
                        fontFamily: "tepeno",
                        fontSize: 12.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return CircularProgressIndicator();
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
