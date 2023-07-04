import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/auth/view/login_screen.dart';
import 'package:gspe_mobile_workshop/src/feature/dashboard/home_sreen.dart';
import 'package:provider/provider.dart';

// import 'state_manager/state_manager.dart';

class Apps extends StatefulWidget {
  const Apps({super.key});

  @override
  State<Apps> createState() => _AppsState();
}

class _AppsState extends State<Apps> {
  @override
  void initState() {
    super.initState();
    // initFunct();
  }

  // Future<void> initFunct() async {
  //   // final state = context.read<AppState>();
  //   await Future.delayed(const Duration(seconds: 2));
  //   if (mounted) {
  //     if (state.isLogin) {
  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(builder: (context) => HomeScreen()),
  //           (Route<dynamic> route) => false);
  //     } else {
  //       // Navigator.of(context).pushAndRemoveUntil(
  //       //     MaterialPageRoute(builder: (context) => LoginPage()),
  //       //     (Route<dynamic> route) => false);
  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(builder: (context) => LoginPage()),
  //           (Route<dynamic> route) => false);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
