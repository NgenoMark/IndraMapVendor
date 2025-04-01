import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import 'project_vendor_page.dart';
import 'project_executor_page.dart';
import 'project_manager_page.dart';
import 'fieldmen_page.dart';
import 'register_page.dart';
=======
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vendor Login',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}
>>>>>>> 58dfc9860314d825cb89c80da1d297e78c564335

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
<<<<<<< HEAD
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    String username = _usernameController.text;
    String password = _passwordController.text;

    try {
      Map<String, dynamic>? response = await _authService.login(username, password);
      
      if (response != null && response.containsKey('token')) {
        String role = response['role']; // Get the user role from API response
        String token = response['token']; // Get the JWT token

        // Store token & role in shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('user_role', role);

        // Navigate based on role
        Widget nextPage;
        switch (role) {
          case 'ProjectVendor':
            nextPage = ProjectVendorPage();
            break;
          case 'ProjectExecutor':
            nextPage = ProjectExecutorPage();
            break;
          case 'ProjectManager':
            nextPage = ProjectManagerPage();
            break;
          case 'FieldMen':
            nextPage = FieldMenPage();
            break;
          default:
            nextPage = LoginPage();
            break;
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid username or password')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed. Try again.')));
=======

  bool _isLoading = false;

  final String tokenUrl = "https://172.22.1.221:8283/token";
  final String userDetailsUrl = "https://172.22.1.221:8283/mapLogin/1.0.1/login";
  final String authorizationHeader = "Basic MHJfZkRDX3QyamM4Z0luYXJvZjRjT0x5NjZnYTptUzJ3cUpuYXpsM2RrbXV6VHpxMXF0dWI4dndh";

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    String mapVendorNumber = _mapVendorNumberController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String formattedUsername = "$mapVendorNumber#$username";

    try {
      // Step 1: Request Access Token
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

      if (tokenResponse.statusCode != 200) {
        _showError('Invalid credentials. Please try again.');
        return;
      }

      var tokenData = json.decode(tokenResponse.body);
      String accessToken = tokenData['access_token'];

      // Step 2: Fetch User Details
      var userResponse = await http.post(
        Uri.parse(userDetailsUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'idVendor': mapVendorNumber,
          'codUser': username,
          'currentPwd': password,
        }),
      );

      if (userResponse.statusCode != 200) {
        _showError('Failed to retrieve user details.');
        return;
      }

      var userDetails = json.decode(userResponse.body);
      print("User details: $userDetails");

      // Navigate to Dashboard with access token
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(
            mapVendorNumber : mapVendorNumber,
            accessToken : accessToken,
            userDetails : userDetails,
            
          ),
        ),
      );
    } catch (e) {
      _showError('An error occurred. Please try again.');
    } finally {
      setState(() => _isLoading = false);
>>>>>>> 58dfc9860314d825cb89c80da1d297e78c564335
    }

    setState(() => _isLoading = false);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: TextStyle(color: Colors.white)), backgroundColor: Colors.red),
    );
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vendor Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _mapVendorNumberController,
                decoration: InputDecoration(labelText: 'Map Vendor Number'),
                validator: (value) => value!.isEmpty ? 'Enter vendor number' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) => value!.isEmpty ? 'Enter username' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) => value!.isEmpty ? 'Enter password' : null,
              ),
              SizedBox(height: 16),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      child: Text('Login'),
                    ),
<<<<<<< HEAD
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text('Don’t have an account? Register here'),
              ),
=======
>>>>>>> 58dfc9860314d825cb89c80da1d297e78c564335
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