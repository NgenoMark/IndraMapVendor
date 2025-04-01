<<<<<<< HEAD
=======
// lib/services/auth_service.dart
>>>>>>> 58dfc9860314d825cb89c80da1d297e78c564335
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
<<<<<<< HEAD
  final String baseUrl = 'http://localhost:8080/api/auth'; // Replace with your backend URL

  Future<Map<String, dynamic>?> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/login'); // Adjust endpoint if needed

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('token') && responseData.containsKey('role')) {
          return {
            'token': responseData['token'],
            'role': responseData['role'],
          };
        }
      }
    } catch (e) {
      print('Error during login: $e');
    }

    return null;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_role');
  }

  Future<bool> isAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_token');
=======
  final String tokenUrl = "https://172.22.1.221:8283/token";
  final String userDetailsUrl = "https://172.22.1.221:8283/mapLogin/1.0.1/login";
  final String authorizationHeader =
      "Basic MHJfZkRDX3QyamM4Z0luYXJvZjRjT0x5NjZnYTptUzJ3cUpuYXpsM2RrbXV6VHpxMXF0dWI4dndh";

  Future<String?> login(String username, String password) async {
    try {
      var response = await http.post(
        Uri.parse(tokenUrl),
        headers: {
          'Authorization': authorizationHeader,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'username': username,
          'password': password,
          'grant_type': 'password',
        },
      );

      if (response.statusCode == 200) {
        var tokenData = json.decode(response.body);
        return tokenData['access_token'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
>>>>>>> 58dfc9860314d825cb89c80da1d297e78c564335
  }

  Future<Map<String, dynamic>?> fetchUserDetails(String token) async {
    try {
      var response = await http.get(
        Uri.parse(userDetailsUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }
}