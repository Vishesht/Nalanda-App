import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nalandha/pages/studentlist.dart';
import 'package:nalandha/pages/studymaterial.dart';
class Ham extends StatelessWidget {
  final List<String> _listItem = [
    'assets/img.png',
    'assets/img.png',
    'assets/img.png',
    'assets/img.png',
    'assets/img.png',
    'assets/img.png',
    'assets/img.png',
    'assets/img.png',
    'assets/img.png',
  ];
  String str = "";
  String name = "";

  String uid = "";
  String docid = "";
  bool indexTab;

  Ham({this.str,this.name,this.uid,this.docid,this.indexTab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 10,
        title: Text(str,style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/img2.jpg'),
                        fit: BoxFit.cover
                    )
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.black.withOpacity(.4),
                            Colors.black.withOpacity(.2),
                          ]
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(name, style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                      SizedBox(height: 30,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: Center(child: Text("Start Class Now", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new StudyMaterial(title: "Chapters",uid: uid,docid:docid,indexTab: indexTab)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                          colors: [
                            const Color(0xFF3366FF),
                            const Color(0xFF00CCFF),
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(0.0, 1.0),
                          stops: [0.0,1.0],
                          tileMode: TileMode.clamp,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      //color: Colors.white24,
                      height: 100,
                      width: 100,
                      child: Text('Chapters',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),

                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new StudentList(uid: uid)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                          colors: [
                            const Color(0xFF3366FF),
                            const Color(0xFF00CCFF),
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(0.0, 1.0),
                          stops: [0.0,1.0],
                          tileMode: TileMode.clamp,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      //color: Colors.white24,
                      height: 100,
                      width: 100,
                      child: Text('Students',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (BuildContext context) =>
                      //         new Choice()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                          colors: [
                            const Color(0xFF3366FF),
                            const Color(0xFF00CCFF),
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(.0, 1.0),
                          stops: [0.0,1.0],
                          tileMode: TileMode.clamp,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      //color: Colors.white24,
                      height: 100,
                      width: 100,
                      child: Text('Test',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [
                      const Color(0xFF3366FF),
                      const Color(0xFF00CCFF),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 1.0),
                    stops: [0.0,1.0],
                    tileMode: TileMode.clamp,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                //color: Colors.white24,
                height: 50,
                child: SelectableText("Class Join Code:-"+uid ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  cursorColor: Colors.white,showCursor: true,
                  toolbarOptions: ToolbarOptions(
                  copy: true,selectAll: true,cut: false,paste: false,
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
