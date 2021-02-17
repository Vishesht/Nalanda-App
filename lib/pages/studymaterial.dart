import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nalandha/pages/chapters.dart';
class StudyMaterial extends StatelessWidget {
  String title;
  final String uid;
  String docid = "";
  bool indexTab;
  StudyMaterial({this.title,this.uid,this.docid,this.indexTab});
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
        backgroundColor: Colors.white,
        title: Text(title,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "tepeno",
            fontWeight: FontWeight.bold,
          ),),
      ),
      floatingActionButton: indexTab==true ? FloatingActionButton.extended(onPressed: (){
        showdialogbox(context);
      }, label: Text('Add Chapter'),
      icon: Icon(Icons.add),
      backgroundColor: Colors.black,):null,
      body: StreamBuilder<QuerySnapshot>(
        stream: taskcollections
            .document(uid)
            .collection('class')
            .document(docid)
            .collection('subject')
            .orderBy('time')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                String str = ds['subject'];
                String subid = ds.documentID;
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
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      ds['subject'],
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
                              new Chapters(str: 'Topics',uid:uid,docid: docid,subid: subid,indexTab: indexTab)));
                    },
                    onLongPress: () {
                      // delete
                      taskcollections
                          .document(uid)
                          .collection('class')
                          .document(docid)
                          .collection('subject')
                          .document(subid)
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
        title: Text("Chapters"),
        content: Form(
          key: formkey,
          autovalidate: true,
          child: TextFormField(
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              // labelText: "Task",
              labelText: "Add chapter name" ,
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
              taskcollections.document(uid).collection('class').document(docid).collection('subject').add({
                'subject': task,
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

