import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseflutterapp/Photogallery.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<File> image = [];
  bool isuploading = false;
  CollectionReference? imgref;
  Reference? ref;
  File? imagefile;
  List<String> imageurl = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imgref = FirebaseFirestore.instance.collection("imageurl");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add image",
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
          ),
          backgroundColor: Colors.orange,
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    isuploading = true;
                  });
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return Photogallerypage();
                    },
                  ));
                },
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Stack(
          children: [
            GridView.builder(
              itemCount: image.length + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return index == 0
                    ? Center(
                        child: IconButton(
                            onPressed: () async {
                              var img = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              imagefile = File(img!.path);

                              setState(() {
                                image.add(imagefile!);
                              });
                              String uuid = Uuid().v4();
                              var reference = await FirebaseStorage.instance
                                  .ref()
                                  .child("sawveimage/$uuid.jpg")
                                  .putFile(imagefile!);
                              var imgurl = await reference.ref
                                  .getDownloadURL()
                                  .then((value) => imgref!.add({"url": value}));
                              print(imgurl);
                            },
                            icon: const Icon(Icons.add)),
                      )
                    : Container(
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(image[index - 1]))),
                      );
              },
            ),
            isuploading
                ? Center(
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "uploading...",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CircularProgressIndicator()
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
