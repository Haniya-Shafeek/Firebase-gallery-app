import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebaseflutterapp/home.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  final TextEditingController mobilecontroller = TextEditingController();
  bool isvisibility = true;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Future Authetcationsignup(
      {required name, required email, required phone, required pass}) async {
    try {
      var ref = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      var docid = ref.user!.uid.toString();
      var data = {
        "name": name,
        "email": email,
        "phone": phone,
        "password": pass
      };
      var dbref = await FirebaseFirestore.instance
          .collection("mydatabase")
          .doc(docid)
          .set(data);
      Fluttertoast.showToast(msg: "account created");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Homepage(),
          ));
    } on FirebaseException {
      Fluttertoast.showToast(msg: "Failled");
    }
  }

  Future databasestore(name, email, phone, pass, docid) async {
    var data = {"name": name, "email": email, "phone": phone, "password": pass};
    var dbref = await FirebaseFirestore.instance
        .collection("mydatabase")
        .doc(docid)
        .set(data);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            const SizedBox(
              //base container
              height: double.infinity, width: double.infinity,
            ),
            Container(
              //Image  conatiner
              width: double.infinity,
              height: 330,
              decoration: const BoxDecoration(
                  color: Colors.amber,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/bgimage2.jpeg"))),
            ),
            Positioned(
                top: 230,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  child: Container(
                    //textformfiled container
                    height: 570,
                    width: 400,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 246, 244, 244)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Form(
                        key: formkey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Sign-up",
                                style: TextStyle(
                                    color: Colors.brown,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Name",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              TextFormField(
                                controller: namecontroller,
                                decoration: const InputDecoration(
                                    hintText: " Your Name"),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Email",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              TextFormField(
                                controller: emailcontroller,
                                decoration: const InputDecoration(
                                    hintText: " Your Email"),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Phone",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              TextFormField(
                                controller: mobilecontroller,
                                decoration: const InputDecoration(
                                    hintText: " Your Mobile no"),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Password",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "please enter pass";
                                  } else if (value.length < 6) {
                                    return "enter strong password";
                                  }
                                  return null;
                                },
                                obscureText: isvisibility,
                                controller: passcontroller,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isvisibility = !isvisibility;
                                          });
                                        },
                                        icon: Icon(isvisibility
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                    hintText: " Set password"),
                              ),
                              // sign up button
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 23, left: 50),
                                child: GestureDetector(
                                  onTap: () {
                                    if (formkey.currentState!.validate()) {
                                      print("validation success");
                                    } else {
                                      print("validation failed");
                                    }

                                    Authetcationsignup(
                                        name: namecontroller.text,
                                        email: emailcontroller.text,
                                        phone: mobilecontroller.text,
                                        pass: passcontroller.text);
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return const Homepage();
                                      },
                                    ));
                                  },
                                  child: Container(
                                    //Button container
                                    width: 250,
                                    height: 35,
                                    decoration: const BoxDecoration(boxShadow: [
                                      BoxShadow(
                                          offset: Offset(2, 2),
                                          color: Colors.grey,
                                          blurRadius: 0.1)
                                    ], color: Colors.orange),
                                    child: const Center(
                                      child: Text(
                                        "Sign up",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
