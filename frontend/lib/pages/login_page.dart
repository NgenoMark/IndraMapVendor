import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'customer_page.dart';
import 'map_vendor_page.dart';

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
  final TextEditingController _mapVendorNumberController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final String tokenUrl =
      "https://172.22.1.221:8283/token"; // Replace with actual token URL
  final String userDetailsUrl =
      "https://172.22.1.221:8283/mapLogin/1.0.1/login"; // Replace with actual user details URL
  final String authorizationHeader =
      "Basic MHJfZkRDX3QyamM4Z0luYXJvZjRjT0x5NjZnYTptUzJ3cUpuYXpsM2RrbXV6VHpxMXF0dWI4dndh"; // Replace with actual value

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

          print("Access token is: $accessToken");

          // Fetch user details using access token
          var userResponse = await http.post(
            Uri.parse(userDetailsUrl),
            headers: {
              'Authorization': 'Bearer $accessToken',
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'idVendor': mapVendorNumber,
              'codUser': password,
              'currentPwd': password,
            }),
          );

          if (userResponse.statusCode == 200) {
            var userDetails = json.decode(userResponse.body);

            // Navigate to MapVendorPage with mapVendorId and accessToken
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MapVendorPage(
                  mapVendorId: mapVendorNumber,
                  accessToken: accessToken,
                ),
              ),
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
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
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
                validator: (value) =>
                    value!.isEmpty ? 'Enter vendor number' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter username' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter password' : null,
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















// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'map_vendor_page.dart';

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

//   final String tokenUrl = "https://172.22.1.221:8283/token"; 
//   final String userDetailsUrl = "https://172.22.1.221:8283/mapLogin/1.0.1/login"; 
//   final String authorizationHeader = "Basic MHJfZkRDX3QyamM4Z0luYXJvZjRjT0x5NjZnYTptUzJ3cUpuYXpsM2RrbXV6VHpxMXF0dWI4dndh"; 

//   Future<void> _login() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       String mapVendorNumber = _mapVendorNumberController.text.trim();
//       String username = _usernameController.text.trim();
//       String password = _passwordController.text.trim();
//       String formattedUsername = "$mapVendorNumber#$username";

//       try {
//         var response = await http.post(
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
//           print("Access token is: $accessToken");

//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => MapVendorPage(mapVendorId: mapVendorNumber, accessToken: accessToken),
//             ),
//           );
//         } else {
//           _showError('Invalid credentials. Please try again.');
//         }
//       } catch (e) {
//         _showError('An error occurred. Please try again later.');
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
