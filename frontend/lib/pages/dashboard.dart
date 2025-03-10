import 'package:flutter/material.dart';
import 'map_vendor_page.dart';

void main() {
  runApp(DashboardApp());
}

class DashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashBoard', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'juma',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Welcome back', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),

            // Work Status Section
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Work status', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Click to reload data'),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: Text('Refresh Data', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Map Survey Summary
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Map Survey Summary', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Container(
                      height: 100,
                      child: MapVendorPage(
                        mapVendorId: "VM012",
                        accessToken: "your_access_token",
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Spacer(),

            // Bottom Navigation Bar
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
                BottomNavigationBarItem(icon: Icon(Icons.poll), label: 'SURVEY'),
                BottomNavigationBarItem(icon: Icon(Icons.build), label: 'INSTALL'),
                BottomNavigationBarItem(icon: Icon(Icons.support), label: 'SUPPORT'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PROFILE'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
