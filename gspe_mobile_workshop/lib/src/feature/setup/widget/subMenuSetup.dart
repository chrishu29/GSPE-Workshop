import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/dashboard/home_sreen.dart';
import 'package:gspe_mobile_workshop/src/feature/setup/widget/diagnosisMatrixList.dart';
import 'package:gspe_mobile_workshop/src/feature/setup/widget/employeeSkillList.dart';

class SubMenuSetup {
  static Widget listMenu() {
    List<String> subMenuList = [
      'Diagnosis List Matrix',
      'Employee Skill',
      'Return to Main Menu'
    ];

    List<Widget> route = [
      DiagnosisMatrixList(),
      EmployeeSkillList(),
      HomeScreen()
    ];

    return Material(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.file_open_sharp),
                Text(
                  'Reporting Menu',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: subMenuList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: (MediaQuery.of(context).size.width / 16)),
                    child: Card(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 16,
                        width: MediaQuery.of(context).size.width / 16,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => route[index]),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(subMenuList[index]),
                                Icon(Icons.arrow_forward),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
