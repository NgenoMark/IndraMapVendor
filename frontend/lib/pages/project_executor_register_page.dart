import 'package:flutter/material.dart';

class ProjectExecutorRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register as Project Executor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Company Name'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Company Address'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email Address'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle registration logic here
              },
              child: Text('Register as Project Executor'),
            ),
          ],
        ),
      ),
    );
  }
}
