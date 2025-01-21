import 'package:flutter/material.dart';
import 'project_vendor_register_page.dart';  // Import the registration pages for each user type
import 'project_executor_register_page.dart';
import 'project_manager_register_page.dart';
import 'fieldman_register_page.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProjectVendorRegisterPage()),
                );
              },
              child: Text('Register as Project Vendor'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProjectExecutorRegisterPage()),
                );
              },
              child: Text('Register as Project Executor'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProjectManagerRegisterPage()),
                );
              },
              child: Text('Register as Project Manager'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FieldmanRegisterPage()),
                );
              },
              child: Text('Register as Fieldman'),
            ),
          ],
        ),
      ),
    );
  }
}
