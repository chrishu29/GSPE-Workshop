import 'dart:convert';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

class UserAuth extends StatefulWidget {
  final String email;
  final String pwd;
  UserAuth({super.key, required this.email, required this.pwd});

  @override
  State<UserAuth> createState() => _UserAuthState();
}

class _UserAuthState extends State<UserAuth> {
  void authenticateUser() async {
    String email = widget.email;
    String password = widget.pwd;

    // Create a Map containing the user's email and password
    Map<String, String> userCredentials = {
      "email": email,
      "password": password,
    };

    // Rest of the authentication code...
    // Make a POST request to the authentication API
    Uri apiUrl = Uri.parse("https://your-api-endpoint.com/authenticate");
    var response = await http.post(
      apiUrl,
      body: jsonEncode(userCredentials),
      headers: {'Content-Type': 'application/json'},
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
