import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/auth/func/image_dimension.dart';
import 'package:gspe_mobile_workshop/src/feature/auth/func/login_auth.dart';
import 'package:gspe_mobile_workshop/src/feature/dashboard/home_sreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoginFailed = false;
  bool isLoggingIn = false;
  double imageWidth = 0;
  double imageHeight = 0;
  String mobile = '';
  String workshop = '';

  // Function to handle the login
  void login() async {
    // Set isLoggingIn to true to show the progress indicator
    setState(() {
      isLoggingIn = true;
    });

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          padding: EdgeInsets.symmetric(horizontal: 100),
          content: Text('Verifying Data'),
          duration: Duration(seconds: 1),
        ),
      );

      final auth = await AuthFunc.authenticateUser(
        username: usernameController.text,
        pwd: passwordController.text,
      );

      if (!mounted) {
        return;
      }

      if (auth == '200') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', usernameController.text);
        isLoginFailed = false;

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        setState(() {
          isLoginFailed = true;
        });
      }
    }

    // Set isLoggingIn to false after logging in or encountering an error
    setState(() {
      isLoggingIn = false;
    });
  }

  @override
  void initState() {
    super.initState();
    imageWidth = ImgDimension.calcWidth(imgLoc: 'assets/logoGSPE.png');
    imageHeight = ImgDimension.calcHeight(imgLoc: 'assets/logoGSPE.png');
    mobile = "Mobile";
    workshop = "Workshop";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(children: [
                      Image.asset('assets/workshopImg.png'),
                      Image.asset('assets/logoGSPE.png'),
                      Positioned(
                          top: imageHeight - 45,
                          left: imageWidth + 5,
                          child: Column(
                            children: [
                              Text(
                                mobile,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                workshop,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          )),
                    ]),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              labelText: 'Username',
                            ),
                          ),
                          TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    if (isLoginFailed)
                      Text(
                        'Invalid username or password',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: isLoggingIn ? null : login,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isLoggingIn) // Show the circular progress indicator if isLoggingIn is true
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: CircularProgressIndicator(),
                            ),
                          Text('Login'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
