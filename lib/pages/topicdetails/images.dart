import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'DataHolder.dart';

class ImageScreen extends StatelessWidget {
  bool indexTab;
  ImageScreen({this.indexTab});
  Widget makeImagesGrid() {
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return ImageGridItem(index+1);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text('Images',style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),),
      ),
      floatingActionButton: indexTab==true ? FloatingActionButton.extended(onPressed: (){
        uploadPic();
      }, label: Text('Add Images'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.black,):null,
      body: Container(
        child: makeImagesGrid(),
      ),
    );
  }

  Future<List <dynamic>> uploadPic() async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    StorageReference reference = _storage.ref().child("images");
    StorageUploadTask uploadTask = reference.putFile(image);
  }
}

class ImageGridItem extends StatefulWidget {
  int _index;
  ImageGridItem(int index){
    this._index = index;
  }
  @override
  _ImageGridItemState createState() => _ImageGridItemState();
}

class _ImageGridItemState extends State<ImageGridItem> {
  Uint8List imageFile;
  StorageReference photosref = FirebaseStorage.instance.ref().child("photos");
  getImage(){
    if(!requestedIndexes.contains(widget._index)){
      int MAX_SIZE = 7*1024*1024;
      photosref.child("image_${widget._index}.jpg").getData(MAX_SIZE).then((data){
        this.setState(() {
          imageFile = data;
        });
        imageData.putIfAbsent(widget._index, (){
          return data;
        });
      }).catchError((error){

      });
      requestedIndexes.add(widget._index);
    }
  }

  Widget decideGridTileWidget(){
    if(imageFile == null){
      return Center(child: Text('no Data'));
    }else{
      return Image.memory(imageFile,fit: BoxFit.cover,);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(!imageData.containsKey(widget._index)){
      getImage();
    }else{
      setState(() {
        imageFile = imageData[widget._index];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: decideGridTileWidget(),
    );
  }
}


