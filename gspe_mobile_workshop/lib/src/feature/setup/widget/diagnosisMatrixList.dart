import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/dashboard/home_sreen.dart';
import 'package:gspe_mobile_workshop/src/feature/setup/widget/const_widget/diagnosis_tables.dart';
import 'package:gspe_mobile_workshop/src/feature/setup/widget/newDiagnosisMatrix.dart';

class DiagnosisMatrixList extends StatelessWidget {
  const DiagnosisMatrixList({super.key});

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
                          'Diagnosis Matrix List',
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
                                builder: (context) => EntryDiagnosisMatrix()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text('Create new Diagnosis Matrix'))
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
                        'Search',
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
                  child: DiagnosisMatrixTable.table(),
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
