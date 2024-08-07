import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: const Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.question_mark),
                      Text("Note"),
                      Column(
                        children: [
                          Text("Please make sure to carefully read ot"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: const Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.question_mark),
                      Text("Note"),
                      Column(
                        children: [
                          Text("All widgets exported by the flutter"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          const Text("Bloc Widgets"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.amber,
              ),
              child: const Column(
                children: [
                  Text(
                      "BlocBuilder is a Flutter widget which requires a Bloc and a builder function. BlocBuilder handles building the widget in response to new states. BlocBuilder "),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
