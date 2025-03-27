import 'package:flutter/material.dart';
import 'package:frontend/pages/dashboard.dart';
import 'dart:async';
import 'pages/login_page.dart'; // Import your login page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      // For testing - navigate directly to Dashboard with test credentials
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(
            mapVendorNumber: "VM012", // Test vendor number
            accessToken: "test_access_token", // Test token
            userDetails: {"username": "test_user"}, // Test user details
          ),
        ),
      );

      // For production - navigate to LoginPage
      
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => LoginPage()),
      // );
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace with your actual logo asset
            Image.asset(
              "assets/splash_logo.png",
              width: 200,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.business, size: 100),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 20),
            const Text(
              'Loading...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}