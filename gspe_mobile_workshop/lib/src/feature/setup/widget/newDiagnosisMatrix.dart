import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/dashboard/home_sreen.dart';

class EntryDiagnosisMatrix extends StatefulWidget {
  const EntryDiagnosisMatrix({super.key});

  @override
  State<EntryDiagnosisMatrix> createState() => _EntryDiagnosisMatrixState();
}

class _EntryDiagnosisMatrixState extends State<EntryDiagnosisMatrix> {
  TextEditingController _diagnosisNameController = TextEditingController();
  TextEditingController _estimatedController = TextEditingController();

  String _selectedSkillLevel = '';

  List<String> _skillLevel = [
    'Simple',
    'Medium',
    'Hard',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
                child: SizedBox(
              height: 500,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.flag),
                          const SizedBox(height: 5),
                          Text('Entry New Diagnosis Matrix'),
                        ],
                      ),
                      DropdownButtonFormField(
                        value: _skillLevel.first,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedSkillLevel = newValue!;
                          });
                        },
                        items: _skillLevel.map<DropdownMenuItem<String>>((level) {
                          return DropdownMenuItem(
                            value: level,
                            child: Text(level),
                          );
                        }).toList(),
                        decoration: InputDecoration(labelText: 'Skill Level'),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _diagnosisNameController,
                        decoration:
                            InputDecoration(labelText: 'Diagnosis Matrix Name'),
                      ),
                      TextField(
                        controller: _estimatedController,
                        decoration: InputDecoration(
                            labelText: 'Estimated Duration (Minutes)'),
                        obscureText: true,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Perform registration logic here
                          String diagnosisName = _diagnosisNameController.text;
                          String estimated = _estimatedController.text;
                          String skillLevel = _selectedSkillLevel;
                
                          // Validate inputs, perform registration, etc.
                
                          print('Entry Diagnosis button pressed');
                          print('Diagnosis Name: $diagnosisName');
                          print('Estimated Duration: $estimated');
                          print('Skill Level: $skillLevel');
                
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomeScreen()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            )),
            //Table for Detail Product From RR
            // Card(
            //     child: Column(
            //   children: [
            //     Row(
            //       children: [
            //         Icon(Icons.stacked_bar_chart),
            //         Text('Detail Product From RR'),
            //       ],
            //     ),
            //     DetailsProductFromRR.table(),
            //   ],
            // )),
            // //table for Serial Number
            // Card(
            //     child: Column(
            //   children: [
            //     Row(
            //       children: [
            //         Icon(Icons.stacked_bar_chart),
            //         Text('Serial Number'),
            //       ],
            //     ),
            //     DetailsProductFromRR.table(),
            //   ],
            // )),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _diagnosisNameController.dispose();
    _estimatedController.dispose();
    super.dispose();
  }
}
