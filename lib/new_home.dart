import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewHome extends StatefulWidget {
  const NewHome({super.key});

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter"),
          backgroundColor: Colors.grey[200],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
          builder: (context, snapshots) {
            return ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> userMap =
                    snapshots.data!.docs[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(userMap["name"]),
                  subtitle: Text(userMap["email"]),
                );
              },
            );
          },
        ));
  }
}
