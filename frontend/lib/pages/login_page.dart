// lib/pages/login_page.dart
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'map_vendor_page.dart';

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
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    String? token = await _authService.getToken();
    if (token != null) {
      _fetchUserDetails(token);
    }
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    String mapVendorNumber = _mapVendorNumberController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String formattedUsername = "$mapVendorNumber#$username";

    String? token = await _authService.login(formattedUsername, password);

    if (token != null) {
      await _authService.saveToken(token);
      await _fetchUserDetails(token);
    } else {
      _showError("Invalid credentials. Please try again.");
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fetchUserDetails(String token) async {
    var userDetails = await _authService.fetchUserDetails(token);

    if (userDetails != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MapVendorPage(userDetails: userDetails),
        ),
      );
    } else {
      _showError("Failed to fetch user details.");
    }
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
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
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