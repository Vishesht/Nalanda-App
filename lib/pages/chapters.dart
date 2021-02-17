import 'package:nalandha/pages/topicdetails.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chapters extends StatelessWidget {
  String str = "";
  String uid = "";
  String docid = "";
  String subid = "";
  bool indexTab;

  Chapters({this.str,this.uid,this.docid,this.subid,this.indexTab});

  String task;
  var taskcollections = Firestore.instance.collection('tasks');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(str,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "tepeno",
            fontWeight: FontWeight.bold,
          ),),
        backgroundColor: Colors.white,
      ),
      floatingActionButton: indexTab==true ? FloatingActionButton.extended(onPressed: (){
        showdialogbox(context);
      }, label: Text('Add Topics'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.black,):null,
      body: StreamBuilder<QuerySnapshot>(
        stream: taskcollections
            .document(uid)
            .collection('class')
            .document(docid)
            .collection('subject')
            .document(subid)
            .collection('topics')
            .orderBy('time')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                String texts = ds['topics'];
                String subid2 = ds.documentID;
                return Container(
                  height: 50,
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
                  ),
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      ds['topics'],
                      style: TextStyle(
                        fontFamily: "tepeno",
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new TopicDetails(str: texts,uid:uid,docid: docid,subid: subid,subid2: subid2,indexTab: indexTab)));
                    },
                    onLongPress: () {
                      // delete
                      taskcollections
                          .document(uid)
                          .collection('class')
                          .document(docid)
                          .collection('subject')
                          .document(subid)
                          .collection('topics')
                          .document(subid2)
                          .delete();
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

  void showdialogbox(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Topics"),
        content: Form(
          key: formkey,
          autovalidate: true,
          child: TextFormField(
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              // labelText: "Task",
              labelText: "Add topic name" ,
            ),
            validator: (_val) {
              if (_val.isEmpty) {
                return "Can't Be Empty";
              } else {
                return null;
              }
            },
            onChanged: (_val) {
              task = _val;
            },
          ),
        ),
        actions: <Widget>[
          RaisedButton(
            color: Colors.black,
            onPressed: () {
              taskcollections.document(uid).collection('class').document(docid)
                  .collection('subject').document(subid).collection('topics')
                  .add({'topics': task,
                'time': DateTime.now(),
              });
              print('success');

              Navigator.pop(context);
            },
            child: Text(
              "Add",
              style: TextStyle(
                fontFamily: "tepeno",
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    });
  }
}


