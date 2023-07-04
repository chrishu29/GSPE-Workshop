import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthFunc {
  static Future<bool> login(
      {required String username, required String password}) async {
    if (username == 'Admin' && password == 'Admin') {
      // Login successful
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } else {
      // Login failed
      await Future.delayed(const Duration(seconds: 1));
      return false;
    }
  }

  static Future<String> authenticateUser(
      {required String username, required String pwd}) async {
    String email = username;
    String password = pwd;

    // Create a Map containing the user's email and password
    Map<String, String> userCredentials = {
      "email": email,
      "password": password,
    };

    // Rest of the authentication code...
    // Make a POST request to the authentication API
    Uri apiUrl = Uri.parse("http://workshop.iotech.my.id/api/login");
    var response = await http.post(
      apiUrl,
      body: jsonEncode(userCredentials),
      headers: {'Content-Type': 'application/json'},
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Use the API response here
      String apiResponse = response.body;
      print(apiResponse);

      // Save the API response to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('apiResponse', apiResponse);

      // You can also parse the response JSON if needed
      // Map<String, dynamic> jsonResponse = jsonDecode(apiResponse);
      // Access specific data from the JSON response
      // String token = jsonResponse['token'];
      // Use the token or other data as needed
      // print(token);

      return response.statusCode.toString();
    } else {
      // If the request was not successful, handle the error here
      print('Request failed with status: ${response.statusCode}');
      return ''; // Return an empty string or an error message
    }
  }
}
