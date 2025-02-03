import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'customer_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _mapVendorNumberController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final String tokenUrl = "https://172.22.1.221:8283/token";
  final String userDetailsUrl = "https://172.22.1.221:8283/mapLogin/1.0.1/login";
  final String authorizationHeader =
      "Basic MHJfZkRDX3QyamM4Z0luYXJvZjRjT0x5NjZnYTptUzJ3cUpuYXpsM2RrbXV6VHpxMXF0dWI4dndh";

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token != null) {
      await _fetchUserDetails(token);
    }
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    String mapVendorNumber = _mapVendorNumberController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String formattedUsername = "$mapVendorNumber#$username";

    try {
      var tokenResponse = await http.post(
        Uri.parse(tokenUrl),
        headers: {
          'Authorization': authorizationHeader,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'username': formattedUsername,
          'password': password,
          'grant_type': 'password',
        },
      );

      if (tokenResponse.statusCode == 200) {
        var tokenData = json.decode(tokenResponse.body);
        String accessToken = tokenData['access_token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', accessToken);

        await _fetchUserDetails(accessToken);
      } else {
        _showError("Invalid credentials. Please try again.");
      }
    } catch (e) {
      _showError("An error occurred. Please check your connection.");
    }
  }

Future<void> _fetchUserDetails(String token) async {
  try {
    var response = await http.get(
      Uri.parse(userDetailsUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var userDetails = json.decode(response.body);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CustomerPage(userDetails: userDetails),
        ),
      );
    } else {
      _showError("Failed to fetch user details.");
    }
  } catch (e) {
    _showError("An error occurred while fetching user details.");
  }
}


  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    setState(() {});
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vendor Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _mapVendorNumberController,
                decoration: const InputDecoration(labelText: 'Map Vendor Number'),
                validator: (value) => value!.isEmpty ? 'Enter vendor number' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) => value!.isEmpty ? 'Enter username' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) => value!.isEmpty ? 'Enter password' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapVendorNumberController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
