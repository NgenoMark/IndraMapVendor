import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Dashboard(),
        '/mapVendor': (context) => MapVendorScreen(),
      },
    );
  }
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            // TODO: Implement drawer or menu functionality
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Juma',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Welcome back', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),

            // Button to navigate to the MapVendor screen
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mapVendor');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Go to Map', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green, // Highlight selected icon
        unselectedItemColor: Colors.grey,
        currentIndex: 0, // Default selection
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Dashboard()));
              break;
            case 1:
              print("Survey clicked");
              // TODO: Implement Survey navigation
              break;
            case 2:
              print("Install clicked");
              // TODO: Implement Install navigation
              break;
            case 3:
              print("Support clicked");
              // TODO: Implement Support navigation
              break;
            case 4:
              print("Profile clicked");
              // TODO: Implement Profile navigation
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.poll), label: 'SURVEY'),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'INSTALL'),
          BottomNavigationBarItem(icon: Icon(Icons.support), label: 'SUPPORT'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PROFILE'),
        ],
      ),
    );
  }
}

// Dummy MapVendorScreen for navigation
class MapVendorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Vendor'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text('Map Vendor Page'),
      ),
    );
  }
}
