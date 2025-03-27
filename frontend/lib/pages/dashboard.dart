import 'package:flutter/material.dart';
import 'package:frontend/pages/profile_page.dart';
import 'map_vendor_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  final String mapVendorNumber;
  final String accessToken;
  final Map<String, dynamic> userDetails;

  const Dashboard({
    Key? key,
    required this.mapVendorNumber,
    required this.accessToken,
    required this.userDetails,
  }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  int totalProjects = 0;
  int completedProjects = 0;
  int pendingProjects = 0;
  int cancelledProjects = 0;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    fetchProjectData();
  }

  Future<void> fetchProjectData() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8081/project-data/getProjectById/${widget.mapVendorNumber}'),
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final projects = json.decode(response.body) as List;
        setState(() {
          totalProjects = projects.length;
          completedProjects = projects.where((p) => p["completionStatus"] == "Completed").length;
          pendingProjects = projects.where((p) => p["completionStatus"] == "Pending").length;
          cancelledProjects = projects.where((p) => p["completionStatus"] == "Cancelled").length;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load projects (${response.statusCode})';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Network error: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  void _onTabTapped(int index) {
    if (_currentIndex == index) return;
    
    setState(() => _currentIndex = index);
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MapVendorPage(
            mapVendorNumber: widget.mapVendorNumber,
            accessToken: widget.accessToken,
            userDetails: widget.userDetails,
          ),
        ),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ProfilePage(
            mapVendorNumber: widget.mapVendorNumber,
            accessToken: widget.accessToken,
            userDetails: widget.userDetails,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blue,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, ${widget.userDetails['username'] ?? 'Vendor'}!',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Here\'s an overview of your projects:',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 20),
                        _buildProjectSummaryCard(),
                      ],
                    ),
                  ),
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
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
            const Text(
              'Project Status',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildStatusRow('Total', totalProjects, Colors.white),
            const SizedBox(height: 10),
            _buildStatusRow('Completed', completedProjects, Colors.greenAccent),
            const SizedBox(height: 10),
            _buildStatusRow('Pending', pendingProjects, Colors.orangeAccent),
            const SizedBox(height: 10),
            _buildStatusRow('Cancelled', cancelledProjects, Colors.redAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String title, int count, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              '$count',
              style: TextStyle(
                color: color,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}