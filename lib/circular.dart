import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Circular Menu Example")),
        body: const Center(child: CircularMenu()),
      ),
    );
  }
}

class CircularMenu extends StatefulWidget {
  const CircularMenu({super.key});

  @override
  _CircularMenuState createState() => _CircularMenuState();
}

class _CircularMenuState extends State<CircularMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ...List.generate(5, (index) {
          final angle = index * math.pi / 2.5;
          final offset = Offset(
            math.cos(angle) * 100 * _animation.value,
            math.sin(angle) * 100 * _animation.value,
          );
          return Transform.translate(
            offset: offset,
            child: Draggable(
              feedback: const Icon(Icons.ac_unit, size: 50, color: Colors.blue),
              childWhenDragging: Container(),
              child: GestureDetector(
                onTap: () {
                  // Handle icon tap
                },
                child: const Icon(Icons.ac_unit, size: 50, color: Colors.blue),
              ),
              onDragEnd: (details) {
                // Handle drag end
              },
            ),
          );
        }),
        GestureDetector(
          onTap: () {
            if (_controller.isCompleted) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
          },
          child: const Icon(Icons.menu, size: 50, color: Colors.red),
        ),
      ],
    );
  }
}
