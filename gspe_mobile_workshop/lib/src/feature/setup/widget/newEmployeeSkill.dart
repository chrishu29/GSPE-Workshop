import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/dashboard/home_sreen.dart';

class EntryEmployeeSkill extends StatefulWidget {
  const EntryEmployeeSkill({super.key});

  @override
  State<EntryEmployeeSkill> createState() => _EntryEmployeeSkillState();
}

class _EntryEmployeeSkillState extends State<EntryEmployeeSkill> {
  String _selectedEmployee = '';
  String _selectedSkillLevel = '';

  List<String> _Employee = [
    'Employee 1',
    'Employee 2',
    'Employee 3',
  ];

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
                          Text('Entry New Employee Matrix Skill'),
                        ],
                      ),
                      DropdownButtonFormField(
                        value: _Employee.first,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedEmployee = newValue!;
                          });
                        },
                        items: _Employee.map<DropdownMenuItem<String>>((level) {
                          return DropdownMenuItem(
                            value: level,
                            child: Text(level),
                          );
                        }).toList(),
                        decoration:
                            InputDecoration(labelText: 'Select Employee'),
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField(
                        value: _skillLevel.first,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedSkillLevel = newValue!;
                          });
                        },
                        items:
                            _skillLevel.map<DropdownMenuItem<String>>((level) {
                          return DropdownMenuItem(
                            value: level,
                            child: Text(level),
                          );
                        }).toList(),
                        decoration: InputDecoration(labelText: 'Skill Level'),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Perform registration logic here
                          String selectedEmployee = _selectedEmployee;
                          String skillLevel = _selectedSkillLevel;

                          // Validate inputs, perform registration, etc.

                          print('Entry Employee Skill button pressed');
                          print('Elected Employee: $selectedEmployee');
                          print('Skill Level: $skillLevel');

                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
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
}
