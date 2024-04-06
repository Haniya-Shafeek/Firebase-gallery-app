import 'package:firebaseflutterapp/Photogallery.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4))
        .whenComplete(() => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Photogallerypage(),
            )));
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "MY GALLERY",
          style: TextStyle(
              fontSize: 30,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
  }
}
