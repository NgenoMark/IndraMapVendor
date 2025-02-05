// // lib/pages/login_page.dart
// import 'package:flutter/material.dart';
// import '../services/auth_service.dart';
// import 'map_vendor_page.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _mapVendorNumberController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final AuthService _authService = AuthService();
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkLoginStatus();
//   }

//   Future<void> _checkLoginStatus() async {
//     String? token = await _authService.getToken();
//     if (token != null) {
//       _fetchUserDetails(token);
//     }
//   }

//   Future<void> _login() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() {
//       _isLoading = true;
//     });

//     String mapVendorNumber = _mapVendorNumberController.text.trim();
//     String username = _usernameController.text.trim();
//     String password = _passwordController.text.trim();
//     String formattedUsername = "$mapVendorNumber#$username";

//     String? token = await _authService.login(formattedUsername, password);

//     if (token != null) {
//       await _authService.saveToken(token);
//       await _fetchUserDetails(token);
//     } else {
//       _showError("Invalid credentials. Please try again.");
//     }

//     setState(() {
//       _isLoading = false;
//     });
//   }

//   Future<void> _fetchUserDetails(String token) async {
//     var userDetails = await _authService.fetchUserDetails(token);

//     if (userDetails != null) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => MapVendorPage(userDetails: userDetails),
//         ),
//       );
//     } else {
//       _showError("Failed to fetch user details.");
//     }
//   }

//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), backgroundColor: Colors.red),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Vendor Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               TextFormField(
//                 controller: _mapVendorNumberController,
//                 decoration: const InputDecoration(labelText: 'Map Vendor Number'),
//                 validator: (value) => value!.isEmpty ? 'Enter vendor number' : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: const InputDecoration(labelText: 'Username'),
//                 validator: (value) => value!.isEmpty ? 'Enter username' : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: const InputDecoration(labelText: 'Password'),
//                 validator: (value) => value!.isEmpty ? 'Enter password' : null,
//               ),
//               const SizedBox(height: 16),
//               _isLoading
//                   ? CircularProgressIndicator()
//                   : ElevatedButton(
//                       onPressed: _login,
//                       child: const Text('Login'),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _mapVendorNumberController.dispose();
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
// } 




import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'customer_page.dart';

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

  final String tokenUrl = "https://172.22.1.221:8283/token"; // Replace with actual token URL
  final String userDetailsUrl = "https://172.22.1.221:8283/mapLogin/1.0.1/login"; // Replace with actual user details URL
  final String authorizationHeader = "Basic MHJfZkRDX3QyamM4Z0luYXJvZjRjT0x5NjZnYTptUzJ3cUpuYXpsM2RrbXV6VHpxMXF0dWI4dndh"; // Replace with actual value

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      String mapVendorNumber = _mapVendorNumberController.text.trim();
      String username = _usernameController.text.trim();
      String password = _passwordController.text.trim();

      String formattedUsername = "$mapVendorNumber#$username"; // Combine vendor number and username

      try {
        // Send login request to retrieve token
        var response = await http.post(
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

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          String accessToken = data['access_token'];

          // Fetch user details using access token
          var userResponse = await http.post(
            Uri.parse(userDetailsUrl),
            headers: {
              'Authorization': 'Bearer $accessToken',
              'Content-Type': 'application/json',
            },
            body: json.encode({  // Add required body parameters
              'username': formattedUsername,
              'password': password,
              'grant_type' : 'password',
          }),
          );

          if (userResponse.statusCode == 200) {
            var userDetails = json.decode(userResponse.body);
            // Pass user details to CustomerPage if needed
            Navigator.pushReplacement(
              context,
                MaterialPageRoute(builder: (context) => CustomerPage()),

              // MaterialPageRoute(builder: (context) => CustomerPage(userDetails: userDetails)),
            );
          } else {
            _showError('Failed to retrieve user details.');
          }
        } else {
          _showError('Invalid credentials. Please try again.');
        }
      } catch (e) {
        _showError('An error occurred. Please try again later.');
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
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
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
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

//echo | openssl s_client -connect 172.22.1.221:443 -servername 172.22.1.221 | openssl x509 > certificate.pem


// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_certificate_pinning/http_certificate_pinning.dart';
// import 'dart:convert';

// import 'customer_page.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Vendor Login',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: LoginPage(),
//     );
//   }
// }

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _mapVendorNumberController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   final String tokenUrl = "https://your-api.com/token"; // Replace with actual URL
//   final String userDetailsUrl = "https://your-api.com/mapLogin/1.0.1/login"; // Replace with actual URL
//   final String authorizationHeader = "Basic MHJfZkRDX3QyamM4Z0luYXJvZjRjT0x5NjZnYTptUzJ3cUpuYXpsM2RrbXV6VHpxMXF0dWI4dndh"; // Replace with actual value

//   // Secure HTTP Client with SSL Pinning
//   Future<http.Client> createSecureHttpClient() async {
//     return await HttpCertificatePinning.getClient(
//       serverURLs: ["your-api.com"], // Replace with your API domain
//       fingerprints: [
//         "sha256/your_certificate_fingerprint_here" // Replace with actual SSL certificate fingerprint
//       ],
//     );
//   }

//   Future<void> _login() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       String mapVendorNumber = _mapVendorNumberController.text.trim();
//       String username = _usernameController.text.trim();
//       String password = _passwordController.text.trim();
//       String formattedUsername = "$mapVendorNumber#$username";

//       try {
//         var client = await createSecureHttpClient();

//         // Request token
//         var response = await client.post(
//           Uri.parse(tokenUrl),
//           headers: {
//             'Authorization': authorizationHeader,
//             'Content-Type': 'application/x-www-form-urlencoded',
//           },
//           body: {
//             'username': formattedUsername,
//             'password': password,
//             'grant_type': 'password',
//           },
//         );

//         if (response.statusCode == 200) {
//           var data = json.decode(response.body);
//           String accessToken = data['access_token'];

//           // Fetch user details
//           var userResponse = await client.get(
//             Uri.parse(userDetailsUrl),
//             headers: {
//               'Authorization': 'Bearer $accessToken',
//               'Content-Type': 'application/json',
//             },
//           );

//           if (userResponse.statusCode == 200) {
//             var userDetails = json.decode(userResponse.body);
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => CustomerPage()),
//             );
//           } else {
//             _showError('Failed to retrieve user details.');
//           }
//         } else {
//           _showError('Invalid credentials. Please try again.');
//         }
//       } catch (e) {
//         _showError('An error occurred: $e');
//       }
//     }
//   }

//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login Page')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               TextFormField(
//                 controller: _mapVendorNumberController,
//                 decoration: InputDecoration(labelText: 'Map Vendor Number'),
//                 validator: (value) => value!.isEmpty ? 'Enter vendor number' : null,
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: InputDecoration(labelText: 'Username'),
//                 validator: (value) => value!.isEmpty ? 'Enter username' : null,
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(labelText: 'Password'),
//                 validator: (value) => value!.isEmpty ? 'Enter password' : null,
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _login,
//                 child: Text('Login'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _mapVendorNumberController.dispose();
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
// }
