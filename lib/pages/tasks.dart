import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nalandha/controllers/authentications.dart';
import 'package:nalandha/main.dart';
import 'package:nalandha/pages/classroom.dart';
import 'package:nalandha/pages/joinclass.dart';

class TasksPage extends StatefulWidget {
  final String uid;

  TasksPage({Key key, @required this.uid}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState(uid);
}

class _TasksPageState extends State<TasksPage> {
  final String uid;
  _TasksPageState(this.uid);

  var taskcollections = Firestore.instance.collection('tasks');
  String task;

  void showdialog(bool isUpdate, DocumentSnapshot ds) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: isUpdate ? Text("Update Class") : Text("Add Class"),
            content: Form(
              key: formkey,
              autovalidate: true,
              child: TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                 // labelText: "Task",
                  labelText: isUpdate ? "Enter class code" : "Create new class",
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
                  if (formkey.currentState.validate()) {
                    formkey.currentState.save();
                    if (isUpdate) {
                      taskcollections
                          .document(uid)
                          .collection('class')
                          .document(ds.documentID)
                          .updateData({
                        'task': task,
                        'time': DateTime.now(),
                      });
                    } else {
                      //  insert
                      taskcollections.document(uid).collection('class').add({
                        'task': task,
                        'time': DateTime.now(),
                      });
                    }
                    Navigator.pop(context);
                  }
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
  void joinclass() {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Join Class"),
            content: Form(
              key: formkey,
              autovalidate: true,
              child: TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  // labelText: "Task",
                  labelText: "Enter class code",
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
                  if(false){
                    taskcollections.document(task).collection('students').add({
                      'students_id': task,
                      'time': DateTime.now(),
                    });
                  }
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new JoinClass(userid:task,indexTab: false)));
                },
                child: Text(
                  "Join",
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
  void _settingModalBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.add),
                  title: new Text('Create Class'),
                  onTap: (){
                    //_showDialog(context);
                    showdialog(false, null);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.person_add),
                  title: new Text('Join Class'),
                  onTap: () => {
                    //showdialog(true, null),
                    joinclass(),
                  },
                ),
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        //onPressed: () => showdialog(false, null),
        onPressed: () => _settingModalBottomSheet(context),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.white,
        title: Text(
          "Nalanda Education",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "tepeno",
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            color: Colors.black,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () => signOutUser().then((value) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomePage()),
                      (Route<dynamic> route) => false);
            }),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: taskcollections
            .document(uid)
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
                String docid = ds.documentID;
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
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onLongPress: () {
                      // delete
                      taskcollections
                          .document(uid)
                          .collection('class')
                          .document(docid)
                          .delete();
                    },
                    onTap: () {
                      print(ds.documentID);
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new Ham(str: "Classroom",name: name,uid: uid,docid:ds.documentID,indexTab: true)));
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