import 'package:flutter/material.dart';

class ProjectManagerPage extends StatelessWidget {
  const ProjectManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Project Manager')),
      body: Center(child: Text('Welcome to the Project Manager Page')),
    );
  }
}
