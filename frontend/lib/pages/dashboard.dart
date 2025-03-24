import 'package:flutter/material.dart';
import 'package:frontend/pages/profile_page.dart';
import 'map_vendor_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0; // Default to "My Projects"
  int totalProjects = 0;
  int completedProjects = 0;
  int pendingProjects = 0;
  int cancelledProjects = 0;

  @override
  void initState() {
    super.initState();
    fetchProjectData(); // Fetch data when the page loads
  }

  Future<void> fetchProjectData() async {
    String vendorId = "VM012"; // Change this to a dynamic vendor ID if needed
    String url = "http://localhost:8081/project-data/getProjectById/$vendorId";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> projects = json.decode(response.body);

        setState(() {
          totalProjects = projects.length;
          completedProjects = projects.where((p) => p["completionStatus"] == "Completed").length;
          pendingProjects = projects.where((p) => p["completionStatus"] == "Pending").length;
          cancelledProjects = projects.where((p) => p["completionStatus"] == "Cancelled").length;
        });
      } else {
        print("Error fetching data: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }


    void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MapVendorPage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    }
    // For index 1 (My Projects), we're already here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, Vendor!', // Add a welcome message
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Here’s an overview of your projects:',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 20),
              _buildProjectSummaryCard(), // Project stats card
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
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
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProjectStatus('Total', '$totalProjects', Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProjectStatus('Completed', '$completedProjects', Colors.greenAccent),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProjectStatus('Pending', '$pendingProjects', Colors.orangeAccent),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProjectStatus('Cancelled', '$cancelledProjects', Colors.redAccent),
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
