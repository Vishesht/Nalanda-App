import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nalandha/pages/topicdetails/secondPage.dart';
import 'Modal.dart';
class  FirstPage extends StatelessWidget {
  String str = "";
  String uid = "";
  String docid = "";
  String subid = "";
  String subid2 ="";
  bool indexTab;
  List<Modal> itemList=List();
  final mainReference = FirebaseDatabase.instance.reference().child('Database');
  FirstPage({this.str, this.uid, this.docid, this.subid, this.subid2,this.indexTab});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text("Documents",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "tepeno",
            fontWeight: FontWeight.bold,
          ),),
      ),
      body: itemList.length==0?Text("Loading"):ListView.builder(
        itemCount:itemList.length,
        itemBuilder: (context,index){
          return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: GestureDetector(
                onTap: (){
                  String passData=itemList[index].link;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>ViewPdf(),
                          settings: RouteSettings(
                            arguments: passData,
                          )
                      )
                  );
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 130,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 140,
                        child: Card(
                          margin: EdgeInsets.all(18),
                          elevation: 7.0,
                          child: Center(
                            child: Text(itemList[index].name+" "+(index+1).toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          );
        },
      ),
      floatingActionButton: indexTab==true ? FloatingActionButton.extended(onPressed: (){
        getPdfAndUpload();
      }, label: Text('Add Documents'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.black,):null,
    );
  }
  Future getPdfAndUpload()async{
    var rng = new Random();
    String randomName="";
    for (var i = 0; i < 20; i++) {
      //generate
      print(rng.nextInt(100).toString());
      randomName += rng.nextInt(100).toString();
    }
    File file = await FilePicker.getFile(type: FileType.custom);
    String fileName = '${randomName}.pdf';
    savePdf(file.readAsBytesSync(), fileName);
    //function call
  }
  savePdf(List<int> asset, String name) async {
    StorageReference reference = FirebaseStorage.instance.ref().child(name);
    StorageUploadTask uploadTask = reference.putData(asset);
    String url = await (await uploadTask.onComplete).ref.getDownloadURL();
    documentFileUpload(url);
    //function call
  }
  String CreateCryptoRandomString([int length = 32]) {
    final Random _random = Random.secure();
    var values = List<int>.generate(length, (i) => _random.nextInt(256));
    return base64Url.encode(values);
    //generate key
  }
  void documentFileUpload(String str) {
    var data = {
      //store data
      "PDF": str,
      "FileName":"Document",
    };
    mainReference.child(CreateCryptoRandomString()).set(data).then((v) {
      print("Store Successfully");
    });
  }

  @override
  void initState() {
    mainReference.once().then((DataSnapshot snap){
      //get data from firebase
      var data = snap.value;
      itemList.clear();
      data.forEach((key,value){
        Modal m = new Modal(value['PDF'], value['FileName']);
        itemList.add(m);
      });
    });
  }


}