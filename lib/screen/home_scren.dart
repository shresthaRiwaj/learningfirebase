import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learningfirebase/registration/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, bool> userId = {};

  List<String> selectedId = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // void deleteData(String docId) async {
  //   await FirebaseFirestore.instance.collection("users").doc(docId).delete();
  // }

  void deleteSelectedUsers() async {
    for (String id in selectedId) {
      await FirebaseFirestore.instance.collection("users").doc(id).delete();
    }
    setState(() {
      selectedId.clear();
    });
  }

  void logOutPage() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const LoginPage();
    }));
  }

  // void addAccount() async{
  //   await FirebaseFirestore.instance.collection("users").add();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logOutPage();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: const Column(
                          children: [
                            Text("Card 1"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // TextField(
              //   controller: _nameController,
              //   decoration: const InputDecoration(hintText: "Name"),
              // ),
              // TextField(
              //   controller: _emailController,
              //   decoration: const InputDecoration(hintText: "Email"),
              // ),
              // ElevatedButton(onPressed: (
              //   addAccount();
              // ), child: Text("Add")),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot doc = snapshot.data!.docs[index];
                            Map<String, dynamic> userData =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            String docId = doc.id;
                            if (userId[docId] == null) {
                              userId[docId] = false;
                            }
                            return Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 16,
                                  child: ListTile(
                                    title: Text(userData["name"]),
                                    subtitle: Text(userData["email"]),
                                    trailing: SizedBox(
                                      width: 100,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Checkbox(
                                            value: userId[docId],
                                            activeColor: userId[docId]!
                                                ? Colors.red
                                                : null,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                userId[docId] = value!;
                                                if (value) {
                                                  selectedId.add(docId);
                                                } else {
                                                  selectedId.remove(docId);
                                                }
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    } else {
                      return const Expanded(child: Text("No data"));
                    }
                  } else {
                    return const Expanded(
                      child: Center(
                          // child: CircularProgressIndicator()

                          ),
                    );
                  }
                },
              ),
              ElevatedButton(
                onPressed: () {
                  deleteSelectedUsers();
                },
                child: const Text("Delete Selected Users"),
              ),
              // Text(selectedId.toString()),
              // Text(userId.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
