import 'package:nalandha/pages/topicdetails/documents.dart';
import 'package:nalandha/pages/topicdetails/images.dart';
import 'package:flutter/material.dart';
import 'package:nalandha/pages/topicdetails/notepad.dart';
import 'package:nalandha/pages/videos.dart';
import 'package:url_launcher/url_launcher.dart';

class TopicDetails extends StatelessWidget {
  String str = "";
  String uid = "";
  String docid = "";
  String subid = "";
  String subid2 = "";
  bool indexTab;

  TopicDetails(
      {this.str, this.uid, this.docid, this.subid, this.subid2, this.indexTab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text(
          str,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                      image: AssetImage('assets/img2.jpg'), fit: BoxFit.cover),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient:
                          LinearGradient(begin: Alignment.bottomRight, colors: [
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.2),
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Study Material',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      new GestureDetector(
                        onTap: () {
                          launch("https://meet.google.com/vpe-crvf-zfa");
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Center(
                          //     child: Text(
                          //   "Start Class Now ${Icons.video_call}",
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Start Class Now ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Icon(Icons.video_call_rounded,size: 22,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new ImageScreen(indexTab: indexTab)));
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
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      //color: Colors.white24,
                      height: 100,
                      width: 100,
                      child: Text(
                        'Images',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => new Videos(
                                  str: str,
                                  uid: uid,
                                  docid: docid,
                                  subid: subid,
                                  subid2: subid2,
                                  indexTab: indexTab)));
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
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      //color: Colors.white24,
                      height: 100,
                      width: 100,
                      child: Text(
                        'Videos',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => new FirstPage(
                                  str: str,
                                  uid: uid,
                                  docid: docid,
                                  subid: subid,
                                  subid2: subid2,
                                  indexTab: indexTab)));
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
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      //color: Colors.white24,
                      height: 100,
                      width: 100,
                      child: Text(
                        'Documents',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new Notepad(indexTab: indexTab)));
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
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      //color: Colors.white24,
                      height: 100,
                      width: 100,
                      child: Text(
                        'Notes',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  // Container(
                  //   color: Colors.white24,
                  //   height: 100,
                  //   width: 100,
                  //   child: Text('Assignments',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                  //
                  // ),
                  // InkWell(
                  //   onTap: (){
                  //     Navigator.push(
                  //         context,
                  //         new MaterialPageRoute(
                  //             builder: (BuildContext context) =>
                  //             new ImageScreen()));
                  //   },
                  //   child: Container(
                  //     color: Colors.white24,
                  //     height: 100,
                  //     width: 100,
                  //     child: Text('Images',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
