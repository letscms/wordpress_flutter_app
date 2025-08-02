import 'package:flutter/material.dart';

class AnotherScreen extends StatelessWidget {
  const AnotherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Another Screen')),
      body: const Center(
        child: Text('This is another screen'),
      ),
    );
  }
}