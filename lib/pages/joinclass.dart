import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nalandha/pages/classroom.dart';

class JoinClass extends StatelessWidget {
  String userid;
  bool indexTab;
  JoinClass({this.userid,this.indexTab});
  var taskcollections = Firestore.instance.collection('tasks');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 10,
        backgroundColor: Colors.white,
        title: Text("Join Class",
          style: TextStyle(
          color: Colors.black,
          fontFamily: "tepeno",
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: taskcollections
            .document(userid)
            .collection('class')
            .orderBy('time')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                String name = ds['task'];
                return Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                      colors: [
                        const Color(0xFF3366FF),
                        const Color(0xFF00CCFF),
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0,1.0],
                      tileMode: TileMode.clamp,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      ds['task'],
                      style: TextStyle(
                        fontFamily: "tepeno",
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      print(ds.documentID);
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new Ham(str: "Join Class",name: name,uid: userid,docid:ds.documentID,indexTab: indexTab)));
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
