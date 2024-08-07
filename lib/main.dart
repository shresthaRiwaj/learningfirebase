import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learningfirebase/category.dart';
import 'package:learningfirebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("users").get();
  // for (var doc in querySnapshot.docs) {
  //   log(doc.data.toString());
  // }

  // DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
  //     .collection("users")
  //     .doc("cbOzNPiQ2E3WOluFk5ls")
  //     .get();
  // log(documentSnapshot.data().toString());

  Map<String, dynamic> newUser = {"name": "Gray", "email": "gray@gmail.com"};

  // await FirebaseFirestore.instance.collection("users").add(newUser);
  // await FirebaseFirestore.instance
  //     .collection("users")
  //     .doc("cbOzNPiQ2E3WOluFk5ls")
  //     .update({"name": "Hello2"});
  // log("User updated");
  // runApp(const MyApp());

  // await FirebaseFirestore.instance
  //     .collection("users")
  //     .doc("5h62GKoCGMstmeKhrAxn")
  //     .delete();
  // for (var doc in querySnapshot.docs) {
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc()
  //       .delete();
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: (FirebaseAuth.instance.currentUser != null)
      //     ? const HomeScreen()
      //     : const LoginPage(),
      home: CategoryPage(),
    );
  }
}
