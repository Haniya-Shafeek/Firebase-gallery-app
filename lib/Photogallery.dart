import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseflutterapp/home.dart';
import 'package:firebaseflutterapp/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Photogallerypage extends StatefulWidget {
  const Photogallerypage({super.key});

  @override
  State<Photogallerypage> createState() => _PhotogallerypageState();
}

class _PhotogallerypageState extends State<Photogallerypage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const Homepage();
              },
            ));
          },
          child: const Icon(Icons.add),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profilescreen(),
                    ));
                        },
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.amber,
                          backgroundImage: NetworkImage(
                              "https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                        ),
                      ),
                      Text(
                        "Gallery",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber),
                      ),
                      Icon(
                        Icons.settings,
                        color: Colors.white,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                top: 150,
                child: Container(
                  height: 600,
                  width: 400,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("imageurl")
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.data == null) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return MasonryGridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                height: 200,
                                decoration:
                                    const BoxDecoration(color: Colors.blue),
                                child: const CircularProgressIndicator(),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MasonryGridView.builder(
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            itemCount: snapshot.data!.docs.length,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(2),
                                child: Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(snapshot
                                            .data!.docs[index]
                                            .get("url"))),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return MasonryGridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                height: 200,
                                decoration:
                                    const BoxDecoration(color: Colors.blue),
                                child: const Center(
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
