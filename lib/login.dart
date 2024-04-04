
import 'package:firebaseflutterapp/home.dart';

import 'package:firebaseflutterapp/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  Future authenticatinlogin(
      {required email, required password, required context}) async {
    try {
      var reference = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
           Fluttertoast.showToast(msg: "Successfully logined");
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const Homepage();
        },
      ));
    } on FirebaseAuthException {
      Fluttertoast.showToast(msg: "failed login", backgroundColor: Colors.red);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Container(
              //base container
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.amber,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1529539795054-3c162aab037a?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bG9naW58ZW58MHx8MHx8fDA%3D"))),
            ),
            Positioned(
                top: 220,
                left: 35,
                child: Container(
                  //textformfield container
                  height: 370,
                  width: 320,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white.withOpacity(0.5)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 15, right: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailcontroller,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Colors.grey,
                              ),
                              hintText: "   Email",
                              hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: passcontroller,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              hintText: "   Password",
                              hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () => authenticatinlogin(email: emailcontroller.text, password: passcontroller.text, context: context),
                          child: Container(
                            //Button container
                            width: 250,
                            height: 50,
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(
                                  offset: Offset(2, 2),
                                  color: Colors.grey,
                                  blurRadius: 0.1)
                            ], color: Colors.orange),
                            child: const Center(
                              child: Text(
                                "Log In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Row(
                            // signup text row
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Signuppage(),
                                        ));
                                  },
                                  child: const Text(
                                    "Sign up",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 31, 114, 33),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            const Positioned(
                top: 50,
                left: 135,
                child: Text(
                  //Heading
                  "LOG IN",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
