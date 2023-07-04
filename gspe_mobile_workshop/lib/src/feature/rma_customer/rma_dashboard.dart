import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/dashboard/home_sreen.dart';
import 'package:gspe_mobile_workshop/src/feature/rma_customer/widget/register_rma.dart';

class RMADashboard extends StatelessWidget {
  const RMADashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Diagnosis Dashboard')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.flag),
                        Text(
                          'RMA Customer',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => RegisterRMA()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text('Register'))
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        'Find RMA',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // SearchBar(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  // child: Tables.table(),
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      Future.delayed(const Duration(milliseconds: 200), () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (Route<dynamic> route) => false,
                        );
                      });
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text('Back to Home')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
