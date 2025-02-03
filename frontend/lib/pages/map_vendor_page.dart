// lib/pages/map_vendor_page.dart
import 'package:flutter/material.dart';

class MapVendorPage extends StatelessWidget {
  final Map<String, dynamic> userDetails;

  const MapVendorPage({super.key, required this.userDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Vendor Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${userDetails['username'] ?? 'Vendor'}!'),
            const SizedBox(height: 20),
            Text('Vendor Number: ${userDetails['vendorNumber'] ?? 'N/A'}'),
            const SizedBox(height: 20),
            Text('Email: ${userDetails['email'] ?? 'N/A'}'),
          ],
        ),
      ),
    );
  }
}