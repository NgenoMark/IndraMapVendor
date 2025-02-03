// lib/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
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