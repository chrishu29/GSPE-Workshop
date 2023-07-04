import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/dashboard/home_sreen.dart';
import 'package:intl/intl.dart';

class RepairmentEntryDashboard extends StatefulWidget {
  const RepairmentEntryDashboard({super.key});

  @override
  State<RepairmentEntryDashboard> createState() =>
      _RepairmentEntryDashboardState();
}

class _RepairmentEntryDashboardState extends State<RepairmentEntryDashboard> {
  TextEditingController _partNameController = TextEditingController();
  TextEditingController _partDescController = TextEditingController();
  TextEditingController _manufacturerController = TextEditingController();
  TextEditingController _serialnumController = TextEditingController();
  TextEditingController _estDurationController = TextEditingController();
  TextEditingController _searchInvenController = TextEditingController();

  String _repairableOptions = '';
  String _dMatrix = '';
  DateTime? _startRepairDate;
  DateTime? _endRepairDate;

  List<String> _options = [
    'Yes',
    'No',
  ];

  Future<void> _selectStartRepairDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _startRepairDate) {
      setState(() {
        _startRepairDate = picked;
      });
    }
  }

  Future<void> _selectEndRepairDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _endRepairDate) {
      setState(() {
        _endRepairDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    child: Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.flag),
                              const SizedBox(height: 5),
                              Text('Repairment Entry'),
                            ],
                          ),
                          SizedBox(height: 16),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Serial Number'),
                              TextField(
                                controller: _serialnumController,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Part Name'),
                              TextField(
                                controller: _partNameController,
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
                          // DropdownButtonFormField(
                          //   value: _options.first,
                          //   onChanged: (newValues) {
                          //     setState(() {
                          //       _repairableOptions = newValues!;
                          //     });
                          //   },
                          //   items: _options
                          //       .map<DropdownMenuItem<String>>((rapair) {
                          //     return DropdownMenuItem(
                          //       value: rapair,
                          //       child: Text(rapair),
                          //     );
                          //   }).toList(),
                          //   decoration: InputDecoration(
                          //     labelText: 'Repairable',
                          //     border: OutlineInputBorder(),
                          //   ),
                          // ),
                          // SizedBox(height: 16),
                          // Column(
                          //   children: [
                          //     Text('Estimated Duration (Mins)'),
                          //     TextField(
                          //       controller: _estDurationController,
                          //       enabled: false,
                          //       decoration: InputDecoration(
                          //         border: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(10.0),
                          //         ),
                          //       ),
                          //       onChanged: (value) {
                          //         // Perform search operation based on the entered value
                          //         // You can update the search results or trigger a search callback here
                          //         print('Search query: $value');
                          //       },
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(_startRepairDate == null
                                  ? 'Pick Start Repair Date'
                                  : DateFormat('dd-MM-yyyy')
                                      .format(_startRepairDate!)),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _selectStartRepairDate(context);
                                },
                                child: Text('Start Repair Date'),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(_endRepairDate == null
                                  ? 'Pick End Repair Date'
                                  : DateFormat('dd-MM-yyyy')
                                      .format(_endRepairDate!)),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _selectEndRepairDate(context);
                                },
                                child: Text('End Repair Date'),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          //Diagnosis Cards
                          // Card(
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(15),
                          //     child: Column(
                          //       children: [
                          //         Row(
                          //           children: [
                          //             Icon(Icons.storage),
                          //             const SizedBox(width: 5),
                          //             Text('Diagnosis Result'),
                          //           ],
                          //         ),
                          //         SizedBox(height: 20),
                          //         Column(
                          //           children: [
                          //             Text('Add Faulty Diagnosis Matrix :'),
                          //             DropdownButtonFormField(
                          //               value: _diagnosisMatrix.first,
                          //               onChanged: (newValues) {
                          //                 setState(() {
                          //                   _dMatrix = newValues!;
                          //                 });
                          //               },
                          //               items: _diagnosisMatrix
                          //                   .map<DropdownMenuItem<String>>(
                          //                       (dmatrix) {
                          //                 return DropdownMenuItem(
                          //                   value: dmatrix,
                          //                   child: Text(dmatrix),
                          //                 );
                          //               }).toList(),
                          //               decoration: InputDecoration(
                          //                 border: OutlineInputBorder(),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //         //Diagnosis result Table
                          //         SizedBox(height: 16),
                          //         Column(
                          //           children: [
                          //             Table(
                          //               border: TableBorder.all(
                          //                   color: Colors.grey,
                          //                   width: 2.0,
                          //                   style: BorderStyle.solid,
                          //                   borderRadius:
                          //                       BorderRadius.circular(10)),
                          //               defaultVerticalAlignment:
                          //                   TableCellVerticalAlignment.middle,
                          //               columnWidths: {
                          //                 0: FlexColumnWidth(1),
                          //                 1: FlexColumnWidth(2),
                          //                 2: FlexColumnWidth(2),
                          //               },
                          //               children: [
                          //                 TableRow(
                          //                   decoration: BoxDecoration(
                          //                     borderRadius:
                          //                         BorderRadius.circular(10),
                          //                     color: Colors.grey[300],
                          //                   ),
                          //                   children: [
                          //                     TableCell(
                          //                       child: Center(
                          //                           child: Text(
                          //                         'Description',
                          //                         style: TextStyle(
                          //                           fontSize: 18,
                          //                           fontWeight: FontWeight.bold,
                          //                         ),
                          //                       )),
                          //                     ),
                          //                     TableCell(
                          //                       child: Center(
                          //                           child: Text(
                          //                         'Estimate Duration (Minutes)',
                          //                         style: TextStyle(
                          //                           fontSize: 18,
                          //                           fontWeight: FontWeight.bold,
                          //                         ),
                          //                       )),
                          //                     ),
                          //                     TableCell(
                          //                       child: Center(
                          //                           child: Text(
                          //                         'Remark',
                          //                         style: TextStyle(
                          //                           fontSize: 18,
                          //                           fontWeight: FontWeight.bold,
                          //                         ),
                          //                       )),
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 TableRow(
                          //                   children: [
                          //                     TableCell(
                          //                       child: Center(
                          //                           child: Text(
                          //                         '1',
                          //                         style:
                          //                             TextStyle(fontSize: 16),
                          //                       )),
                          //                     ),
                          //                     TableCell(
                          //                       child: Center(
                          //                           child: Text(
                          //                         'Cell 4',
                          //                         style:
                          //                             TextStyle(fontSize: 16),
                          //                       )),
                          //                     ),
                          //                     TableCell(
                          //                       child: Center(
                          //                           child: Text(
                          //                         'Cell 5',
                          //                         style:
                          //                             TextStyle(fontSize: 16),
                          //                       )),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: 16),
                          // Card(
                          //     child: Padding(
                          //   padding: const EdgeInsets.all(15),
                          //   child: Column(
                          //     children: [
                          //       Row(
                          //         children: [
                          //           Icon(Icons.stacked_bar_chart),
                          //           const SizedBox(height: 5),
                          //           Text('Replacement Part'),
                          //         ],
                          //       ),
                          //       SizedBox(height: 20),
                          //       Column(
                          //         children: [
                          //           TextField(
                          //             controller: _searchInvenController,
                          //             decoration: InputDecoration(
                          //               hintText: 'Search Part in Inventory',
                          //               prefixIcon: Icon(Icons.search),
                          //               border: OutlineInputBorder(
                          //                 borderRadius:
                          //                     BorderRadius.circular(10.0),
                          //               ),
                          //             ),
                          //             onChanged: (value) {
                          //               // Perform search operation based on the entered value
                          //               // You can update the search results or trigger a search callback here
                          //               print('Search query: $value');
                          //             },
                          //           ),
                          //         ],
                          //       ),
                          //       SizedBox(height: 16),
                          //       Column(
                          //         children: [
                          //           Table(
                          //             border: TableBorder.all(
                          //                 color: Colors.grey,
                          //                 width: 2.0,
                          //                 style: BorderStyle.solid,
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             defaultVerticalAlignment:
                          //                 TableCellVerticalAlignment.middle,
                          //             columnWidths: {
                          //               0: FlexColumnWidth(1),
                          //               1: FlexColumnWidth(2),
                          //               2: FlexColumnWidth(2),
                          //               3: FlexColumnWidth(2),
                          //               4: FlexColumnWidth(2),
                          //               5: FlexColumnWidth(2),
                          //               6: FlexColumnWidth(2),
                          //               7: FlexColumnWidth(2),
                          //               8: FlexColumnWidth(2),
                          //             },
                          //             children: [
                          //               TableRow(
                          //                 decoration: BoxDecoration(
                          //                   borderRadius:
                          //                       BorderRadius.circular(10),
                          //                   color: Colors.grey[300],
                          //                 ),
                          //                 children: [
                          //                   TableCell(
                          //                     child: Center(
                          //                         child: Text(
                          //                       'id',
                          //                       style: TextStyle(
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.bold,
                          //                       ),
                          //                     )),
                          //                   ),
                          //                   TableCell(
                          //                     child: Center(
                          //                         child: Text(
                          //                       'Mfr',
                          //                       style: TextStyle(
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.bold,
                          //                       ),
                          //                     )),
                          //                   ),
                          //                   TableCell(
                          //                     child: Center(
                          //                         child: Text(
                          //                       'Part Number',
                          //                       style: TextStyle(
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.bold,
                          //                       ),
                          //                     )),
                          //                   ),
                          //                   TableCell(
                          //                     child: Center(
                          //                         child: Text(
                          //                       'Part Name',
                          //                       style: TextStyle(
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.bold,
                          //                       ),
                          //                     )),
                          //                   ),
                          //                   TableCell(
                          //                     child: Center(
                          //                         child: Text(
                          //                       'Description',
                          //                       style: TextStyle(
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.bold,
                          //                       ),
                          //                     )),
                          //                   ),
                          //                   TableCell(
                          //                     child: Center(
                          //                         child: Text(
                          //                       'U/M',
                          //                       style: TextStyle(
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.bold,
                          //                       ),
                          //                     )),
                          //                   ),
                          //                   TableCell(
                          //                     child: Center(
                          //                         child: Text(
                          //                       'Qty in Stock',
                          //                       style: TextStyle(
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.bold,
                          //                       ),
                          //                     )),
                          //                   ),
                          //                   TableCell(
                          //                     child: Center(
                          //                         child: Text(
                          //                       'Qty Request',
                          //                       style: TextStyle(
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.bold,
                          //                       ),
                          //                     )),
                          //                   ),
                          //                   TableCell(
                          //                     child: Center(
                          //                         child: Text(
                          //                       'Action',
                          //                       style: TextStyle(
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.bold,
                          //                       ),
                          //                     )),
                          //                   ),
                          //                 ],
                          //               ),
                          //               TableRow(
                          //                 children: [
                          //                   TableCell(
                          //                     child: Center(
                          //                         child: Text(
                          //                       '1',
                          //                       style: TextStyle(fontSize: 16),
                          //                     )),
                          //                   ),
                          //                   TableCell(
                          //                     child: Center(
                          //                         child: Text(
                          //                       'Cell 1',
                          //                       style: TextStyle(fontSize: 16),
                          //                     )),
                          //                   ),
                          //                   TableCell(
                          //                     child: Center(
                          //                         child: Text(
                          //                       'Cell 2',
                          //                       style: TextStyle(fontSize: 16),
                          //                     )),
                          //                   ),
                          //                   TableCell(
                          //                     child: Center(
                          //                         child: Text(
                          //                       'Cell 3',
                          //                       style: TextStyle(fontSize: 16),
                          //                     )),
                          //                   ),
                          //                   TableCell(
                          //                     child: Center(
                          //                         child: Text(
                          //                       'Cell 4',
                          //                       style: TextStyle(fontSize: 16),
                          //                     )),
                          //                   ),
                          //                   TableCell(
                          //                     child: Center(
                          //                         child: Text(
                          //                       'Cell 5',
                          //                       style: TextStyle(fontSize: 16),
                          //                     )),
                          //                   ),
                          //                   TableCell(
                          //                     child: Center(
                          //                         child: Text(
                          //                       'Cell 6',
                          //                       style: TextStyle(fontSize: 16),
                          //                     )),
                          //                   ),
                          //                   TableCell(
                          //                     child: Center(
                          //                         child: Text(
                          //                       'Cell 7',
                          //                       style: TextStyle(fontSize: 16),
                          //                     )),
                          //                   ),
                          //                   TableCell(
                          //                     child: Center(
                          //                         child: Text(
                          //                       'Cell 8',
                          //                       style: TextStyle(fontSize: 16),
                          //                     )),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ],
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // )),
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
                                  String serialnum = _serialnumController.text;
                                  String partname = _partNameController.text;
                                  String partdesc = _partDescController.text;
                                  String manufacturer =
                                      _manufacturerController.text;
                                  String searchinven =
                                      _searchInvenController.text;
                                  String estimatedDuration =
                                      _estDurationController.text;
                                  String diagnosisMatrix = _dMatrix;
                                  String repair = _repairableOptions;
                                  DateTime? startRepair = _startRepairDate;
                                  DateTime? endRepair = _endRepairDate;

                                  // Validate inputs, perform registration, etc.

                                  print('Repair button pressed');
                                  print('Serialnum: $serialnum');
                                  print('Part Name: $partname');
                                  print('Part Desc: $partdesc');
                                  print('Manufacturer: $manufacturer');
                                  // print('Diagnosis Matrix: $diagnosisMatrix');
                                  // print(
                                  //     'Estimated Duration (Mins): $estimatedDuration');
                                  // print('Repairable: $repair');
                                  print('Start Repair Date: $startRepair');
                                  print('End Repair Date: $endRepair');
                                  // print('Search Part in Inventory: $searchinven');

                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: Text('Start Repair'),
                              ),
                            ],
                          ),
                        ],
                      ),
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
    _serialnumController.dispose();
    _partNameController.dispose();
    _partDescController.dispose();
    _manufacturerController.dispose();
    super.dispose();
  }
}
