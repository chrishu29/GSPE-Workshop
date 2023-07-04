import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/dashboard/home_sreen.dart';
import 'package:gspe_mobile_workshop/src/feature/diagnosis/provider/diagnosis_matrix_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DiagnosisEntryDashboard extends StatefulWidget {
  const DiagnosisEntryDashboard({super.key});

  @override
  State<DiagnosisEntryDashboard> createState() =>
      _DiagnosisEntryDashboardState();
}

class _DiagnosisEntryDashboardState extends State<DiagnosisEntryDashboard> {
  TextEditingController _partNameController = TextEditingController();
  TextEditingController _partDescController = TextEditingController();
  TextEditingController _manufacturerController = TextEditingController();
  TextEditingController _searchController = TextEditingController();

  String _repairableOptions = '';
  String _dMatrix = '';
  DateTime? _selectedDate;

  List<String> _options = [
    'Yes',
    'No',
  ];

  // List<String> _diagnosisMatrix = [
  //   'OFF CARD CONTROLLER (Medium) (80 Mins)',
  //   'OFF CARD CONTROLLER (Simple) (80 Mins)',
  //   'OFF MODULE (Medium) (15 Mins)',
  //   'INT CARD CONTROLLER (Simple) (90 Mins)',
  //   'INT MODULE (Simple) (90 Mins)',
  //   'ALARM CARD CONTROLLER (Simple) (70 Mins)',
  //   'ALARM MODULE (Simple) (90 Mins)',
  //   'NO OUTPUT CARD CONTROLLER (Simple) (90 Mins)',
  //   'NO OUTPUT MODEL (Simple) (90 Mins)',
  //   'LOW VOLTAGE : CARD/MODULE CONTROLLER (Simple) (80 Mins)',
  //   'LOW LOAD : CARD/MODULE CONTROLLER (Simple) (90 Mins)',
  //   'FAN OFF (Simple) (15 Mins)',
  //   'FAN OFF & CARD INT (Simple) (90 Mins)',
  //   'MODULE (Simple) (80 Mins)',
  //   'CARD (Simple) (90 Mins)',
  //   'CHANGE/REPAIR COVER (Simple) (15 Mins)',
  //   'No',
  // ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        context.read<DiagMatrixProvider>().getAllData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final DiagMatrix = Provider.of<DiagMatrixProvider>(context, listen: false);
    // print(DiagMatrix.allData);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Card(
                  child: SizedBox(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height
                        : MediaQuery.of(context).size.width,
                width:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.flag),
                            const SizedBox(height: 5),
                            Text('Diagnosis'),
                          ],
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Input Serial Number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onChanged: (value) {
                            // Perform search operation based on the entered value
                            // You can update the search results or trigger a search callback here
                            print('Search query: $value');
                          },
                        ),
                        SizedBox(height: 16),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Part Name'),
                            TextField(
                              controller: _partNameController,
                              enabled: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onChanged: (value) {
                                // Perform search operation based on the entered value
                                // You can update the search results or trigger a search callback here
                                print('Search query: $value');
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Column(
                          children: [
                            Text('Part Desc'),
                            TextField(
                              controller: _partDescController,
                              enabled: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onChanged: (value) {
                                // Perform search operation based on the entered value
                                // You can update the search results or trigger a search callback here
                                print('Search query: $value');
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Column(
                          children: [
                            Text('Manufacturer'),
                            TextField(
                              controller: _manufacturerController,
                              enabled: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onChanged: (value) {
                                // Perform search operation based on the entered value
                                // You can update the search results or trigger a search callback here
                                print('Search query: $value');
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        DropdownButtonFormField(
                          value: _options.first,
                          onChanged: (newValues) {
                            setState(() {
                              _repairableOptions = newValues!;
                            });
                          },
                          items:
                              _options.map<DropdownMenuItem<String>>((rapair) {
                            return DropdownMenuItem(
                              value: rapair,
                              child: Text(rapair),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: 'Repairable',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(_selectedDate == null
                                ? 'Pick Deadline'
                                : DateFormat('dd-MM-yyyy')
                                    .format(_selectedDate!)),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _selectDate(context);
                              },
                              child: Text('Deadline'),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.storage),
                                    const SizedBox(width: 5),
                                    Text('Diagnosis Module'),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Column(
                                  children: [
                                    Text('Choose Diagnosis Matrix :'),
                                    Consumer<DiagMatrixProvider>(
                                        builder: (context, dm, _) {
                                      return DropdownButtonFormField(
                                        value: dm.allData.isEmpty
                                            ? Null
                                            : dm.allData[0].name,
                                        onChanged: (newValues) {
                                          setState(() {
                                            _dMatrix = newValues as String;
                                          });
                                        },
                                        items: dm.allData
                                            .map<DropdownMenuItem<String>>(
                                                (dmatrix) {
                                          return DropdownMenuItem(
                                            value: dmatrix.name,
                                            child: Text(
                                                '${dmatrix.name} (${dmatrix.duration} Minutes)'),
                                          );
                                        }).toList(),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Column(
                                  children: [
                                    Table(
                                      border: TableBorder.all(
                                          color: Colors.grey,
                                          width: 2.0,
                                          style: BorderStyle.solid,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: {
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(2),
                                        2: FlexColumnWidth(2),
                                      },
                                      children: [
                                        TableRow(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey[300],
                                          ),
                                          children: [
                                            TableCell(
                                              child: Center(
                                                  child: Text(
                                                'Description',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                            ),
                                            TableCell(
                                              child: Center(
                                                  child: Text(
                                                'Estimate Duration (Minutes)',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                            ),
                                            TableCell(
                                              child: Center(
                                                  child: Text(
                                                'Remark',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Center(
                                                  child: Text(
                                                '1',
                                                style: TextStyle(fontSize: 16),
                                              )),
                                            ),
                                            TableCell(
                                              child: Center(
                                                  child: Text(
                                                'Cell 1',
                                                style: TextStyle(fontSize: 16),
                                              )),
                                            ),
                                            TableCell(
                                              child: Center(
                                                  child: Text(
                                                'Cell 2',
                                                style: TextStyle(fontSize: 16),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Text('Total Estimate Duration: _ Mins'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.home), // House icon
                                    Text('Back to Home'), // Text widget
                                  ],
                                )),
                            ElevatedButton(
                              onPressed: () {
                                // Perform registration logic here
                                String serialnum = _searchController.text;
                                String partname = _partNameController.text;
                                String partdesc = _partDescController.text;
                                String manufacturer =
                                    _manufacturerController.text;
                                String repair = _repairableOptions;
                                String diagnosisMatrix = _dMatrix;
                                DateTime? deadline = _selectedDate;

                                // Validate inputs, perform registration, etc.

                                print('Diagnosis button pressed');
                                print('Serialnum: $serialnum');
                                print('Part Name: $partname');
                                print('Part Desc: $partdesc');
                                print('Manufacturer: $manufacturer');
                                print('Repairable: $repair');
                                print('Diagnosis Matrix: $diagnosisMatrix');
                                print('Deadline: $deadline');

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
                      ],
                    ),
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _partNameController.dispose();
    _partDescController.dispose();
    _manufacturerController.dispose();
    super.dispose();
  }
}
