import 'package:flutter/material.dart';
import 'project_vendor_register_page.dart';  // Import registration pages for each user type
import 'project_executor_register_page.dart';
import 'project_manager_register_page.dart';
import 'fieldman_register_page.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Account Type')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Select account type',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'or',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[900],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/login'); // Navigate to login page
              },
              child: Text(
                'Sign in',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 30),
            // Buttons for each user type
            Column(
              children: <Widget>[
                // Project Vendor button
                _buildRegisterButton(
                  context,
                  'Register as Project Vendor',
                  'For companies that post projects',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProjectVendorRegisterPage()),
                    );
                  },
                ),
                SizedBox(height: 16),
                // Project Executor button
                _buildRegisterButton(
                  context,
                  'Register as Project Executor',
                  'For companies offering services',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProjectExecutorRegisterPage()),
                    );
                  },
                ),
                SizedBox(height: 16),
                // Project Manager button
                _buildRegisterButton(
                  context,
                  'Register as Project Manager',
                  'Managers within a project executor company',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProjectManagerRegisterPage()),
                    );
                  },
                ),
                SizedBox(height: 16),
                // Fieldman button
                _buildRegisterButton(
                  context,
                  'Register as Fieldman',
                  'Field workers under project managers',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FieldmanRegisterPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Reusable method to build each registration button
  Widget _buildRegisterButton(
    BuildContext context,
    String title,
    String subtitle,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.blue[700],
            ),
          ],
        ),
      ),
    );
  }
}
