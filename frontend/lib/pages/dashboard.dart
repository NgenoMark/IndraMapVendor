import 'package:flutter/material.dart';
import 'map_vendor_page.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView( // Enables scrolling
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Project Overview',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildProjectSummaryCard(), // Single card for project stats
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'My Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Account',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapVendorPage()),
            );
          }
        },
      ),
    );
  }

  Widget _buildProjectSummaryCard() {
    return Card(
      color: Colors.blue.shade700,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Project Status',
              style: TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProjectStatus('Total', '10', Colors.white),
                _buildProjectStatus('Completed', '6', Colors.greenAccent),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProjectStatus('Pending', '3', Colors.orangeAccent),
                _buildProjectStatus('Cancelled', '1', Colors.redAccent),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectStatus(String title, String count, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Dashboard(),
  ));
}
