import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutterapp/Photogallery.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  File? profilepic;
  String username = "";
  String email = "";

  Future<void> changeProfilePic() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      profilepic = File(img!.path);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var ref = FirebaseAuth.instance;
    User user = ref.currentUser!;
    setState(() {
      email = user.email!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade400,
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Photogallerypage(),
                    ));
              },
              child: const Text(
                "Ok",
                style: TextStyle(color: Colors.amber),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Stack(
                  children: [
                    profilepic == null
                        ? const CircleAvatar(
                            radius: 100,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 150,
                            ),
                          )
                        : CircleAvatar(
                            radius: 100,
                            backgroundImage: FileImage(profilepic!),
                          ),
                    Positioned(
                        left: 140,
                        top: 150,
                        child: InkWell(
                          onTap: changeProfilePic,
                          child: const CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.lightGreen,
                              child: Icon(
                                Icons.photo_camera_rounded,
                                color: Colors.white,
                              )),
                        ))
                  ],
                ),
              ),
            ),
            Text(email),
          ],
        ),
      ),
    );
  }
}
