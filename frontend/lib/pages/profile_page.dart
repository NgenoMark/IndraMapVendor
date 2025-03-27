import 'package:flutter/material.dart';
import 'package:frontend/pages/map_vendor_page.dart';
import 'dashboard.dart';

class ProfilePage extends StatefulWidget {
  final String mapVendorNumber;
  final String accessToken;
  final Map<String, dynamic> userDetails;

  const ProfilePage({
    Key? key,
    required this.mapVendorNumber,
    required this.accessToken,
    required this.userDetails,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 2; // Default index for Profile page

  void _onTabTapped(int index) {
    if (_currentIndex == index) return;
    
    setState(() => _currentIndex = index);
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Dashboard(
            mapVendorNumber: widget.mapVendorNumber,
            accessToken: widget.accessToken,
            userDetails: widget.userDetails,
          ),
        ),
      );
    } else if (index == 1) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text(
          'Profile Page Content',
          style: TextStyle(fontSize: 24),
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
}