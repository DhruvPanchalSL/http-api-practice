import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String token;

  const HomePage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Text(
          'Login Successful 🎉\n\nAccess Token:\n$token',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
