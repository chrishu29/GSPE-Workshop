import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/dashboard/home_sreen.dart';
import 'package:gspe_mobile_workshop/src/feature/diagnosis/model/diagnosis_matrix_model.dart';
import 'package:gspe_mobile_workshop/src/feature/diagnosis/model/diagnosis_module_model.dart';
import 'package:gspe_mobile_workshop/src/feature/diagnosis/model/serial_number_model.dart';
import 'package:gspe_mobile_workshop/src/feature/diagnosis/provider/diagnosis_matrix_provider.dart';
import 'package:gspe_mobile_workshop/src/feature/diagnosis/provider/serial_number_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DiagnosisDashboard extends StatefulWidget {
  const DiagnosisDashboard({super.key});

  @override
  State<DiagnosisDashboard> createState() => _DiagnosisDashboardState();
}

class _DiagnosisDashboardState extends State<DiagnosisDashboard> {
  TextEditingController _partNameController = TextEditingController();
  TextEditingController _partDescController = TextEditingController();
  TextEditingController _manufacturerController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();

  String _repairableOptions = '';
  int sumDuration = 0;
  DateTime? _selectedDate;
  bool isLoading = false;
  List<DiagnosisModule> myDiagnosis = [];
  List<SerialNumber> _selectedDataList = [];
  List<String> _options = [
    'Outstanding',
    'Done',
    'Failed',
  ];
  // Initialize empty lists for desc, duration, remark, and matrix_id
  List<String> descList = [];
  List<String> durationList = [];
  List<String> remarkList = [];
  List<String> matrixIdList = [];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = DateTime(picked.year, picked.month, picked.day);
      });
    }
  }

  // Function to handle the API call to save data
  void saveData() async {
    // Set isLoading to true to show the progress indicator
    setState(() {
      isLoading = true;
    });

    // To throw away the 00:00:00 at the end of the deadline
    int lastSpaceIndex = _selectedDate.toString().lastIndexOf(' ');
    String trimmedDeadline =
        _selectedDate.toString().substring(0, lastSpaceIndex);

    //Map each value from the form
    Map<String, dynamic> postData = {
      "diagnosis_detail_id": _selectedDataList[0].rmaDetailId.toString(),
      "product_id": _selectedDataList[0].productId.toString(),
      "id": _selectedDataList[0].rmaDetailId.toString(),
      "repairable": _repairableOptions == "Outstanding"
          ? 0
          : _repairableOptions == "Done"
              ? 1
              : 2,
      "deadline": trimmedDeadline,
      "desc": descList,
      "duration": durationList,
      "remark": remarkList,
      "matrix_id": matrixIdList,
      "total_duration": sumDuration.toString(),
    };

    //iterate the myDiagnosis List if its more than 2 Diagnosis
    for (var diagnosis in myDiagnosis) {
      String description = diagnosis.description;
      RegExp regex = RegExp(
          r'\((.*?)\)'); // Regular expression to match the text inside parentheses
      RegExpMatch? match = regex.firstMatch(description);

      if (match != null) {
        String valueInParentheses =
            match.group(1)!; // Get the value inside parentheses

        String modifiedValue = valueInParentheses.toUpperCase() +
            " REPAIR"; // Append " Repair" to the extracted value

        postData["desc"].add(modifiedValue);
      } else {
        postData["desc"].add(
            description); // If no parentheses found, add the original description
      }
      postData["duration"].add(diagnosis.duration.toString());
      postData["remark"].add(diagnosis.remarks);
      postData["matrix_id"].add(diagnosis.matrixId.toString());
    }

    // Encode the postData as JSON
    String jsonData = jsonEncode(postData);

    try {
      // Make a POST request to the API
      Uri apiUrl = Uri.parse("http://workshop.iotech.my.id/api/save-diagnosis");
      var response = await http.post(
        apiUrl,
        headers: {"Content-Type": "application/json"},
        body: jsonData,
      );

      // Handle the API response
      if (response.statusCode == 200) {
        final currentContext = context; // Capture the current context

        showDialog(
          context:
              currentContext, // Use the captured context within the dialog builder
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text('Message'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Diagnosis Updated Successfully !'),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            );
          },
        );
      } else {
        final currentContext = context; // Capture the current context

        showDialog(
          context:
              currentContext, // Use the captured context within the dialog builder
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text('Error'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Request failed with status: ${response.statusCode}'),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(dialogContext)
                        .pop(); // Use the dialog context to dismiss the dialog
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle any errors during the API call
      // ...
    }

    // Set isLoading to false after receiving the response or error
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        context.read<DiagMatrixProvider>().getAllData();
        context.read<SerialNumProvider>().getAllData();
      },
    );
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
                        Consumer<SerialNumProvider>(builder: (context, sn, _) {
                          final serials = sn.allData;
                          return TypeAheadField(
                            textFieldConfiguration: TextFieldConfiguration(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: 'Search Serial Number',
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                )),
                            suggestionsCallback: (pattern) {
                              return sn.getSuggestions(pattern);
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion),
                              );
                            },
                            onSuggestionSelected: (suggestion) {
                              _searchController.text = suggestion;
                              final selectedSerial = serials.firstWhere(
                                (serial) => serial.serialNum == suggestion,
                                orElse: () => SerialNumber(
                                    rmaDetailId: 0,
                                    rmaNum: '0',
                                    customerName: '-',
                                    siteName: '-',
                                    dateIn: '-',
                                    partName: '-',
                                    partNum: '-',
                                    partDesc: '-',
                                    mfr: '-',
                                    serialNum: '-',
                                    productId: 0),
                              );
                              if (selectedSerial.productId != 0) {
                                _partNameController.text =
                                    selectedSerial.partName;
                                _partDescController.text =
                                    selectedSerial.partDesc;
                                _manufacturerController.text =
                                    selectedSerial.mfr;

                                // Add the selected data to the list
                                _selectedDataList.add(selectedSerial);
                              }
                            },
                          );
                        }),
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
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        DropdownButtonFormField(
                          value: _repairableOptions == ''
                              ? null
                              : _repairableOptions,
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
                                : DateFormat.yMd().format(_selectedDate!)),
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
                                          final selectedName =
                                              newValues as String;
                                          final selectedMatrix =
                                              dm.allData.firstWhere(
                                            (dmatrix) =>
                                                dmatrix.name == selectedName,
                                            orElse: () => DiagnosisMatrix(
                                                id: 0,
                                                name: '-',
                                                level: '-',
                                                duration: 0,
                                                created_at: '-',
                                                updated_at: '-'),
                                          );
                                          setState(() {
                                            DiagnosisModule diagnoze =
                                                DiagnosisModule(
                                                    description: newValues,
                                                    duration:
                                                        selectedMatrix.duration,
                                                    remarks: '',
                                                    matrixId:
                                                        selectedMatrix.id);
                                            myDiagnosis.add(diagnoze);
                                            sumDuration = myDiagnosis.fold(
                                                0,
                                                (int sum,
                                                        DiagnosisModule
                                                            diagnosis) =>
                                                    sum + diagnosis.duration);
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
                                    Consumer<DiagMatrixProvider>(
                                        builder: (context, dm, _) {
                                      return Table(
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
                                          3: FlexColumnWidth(1),
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
                                              TableCell(
                                                child: Center(
                                                    child: Text(
                                                  'Action',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )), // Empty cell for the delete button
                                              ),
                                            ],
                                          ),
                                          for (var element in myDiagnosis)
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Center(
                                                      child: Text(
                                                    element.description,
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  )),
                                                ),
                                                TableCell(
                                                  child: Center(
                                                      child: Text(
                                                    element.duration.toString(),
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  )),
                                                ),
                                                TableCell(
                                                  child: Center(
                                                    child: TextField(
                                                        controller:
                                                            TextEditingController(
                                                          text: element.remarks,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: element
                                                                      .remarks ==
                                                                  ''
                                                              ? 'Input Remarks'
                                                              : element.remarks,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          final text =
                                                              element.remarks;
                                                          _remarkController =
                                                              TextEditingController(
                                                                  text: text);
                                                          _remarkController
                                                                  .selection =
                                                              TextSelection
                                                                  .fromPosition(
                                                            TextPosition(
                                                                offset: text
                                                                    .length),
                                                          );
                                                          element.remarks =
                                                              text; // Update the data model
                                                          _remarkController
                                                              .addListener(() {
                                                            element.remarks =
                                                                _remarkController
                                                                    .text; // Update the data model on every change
                                                          });
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  content:
                                                                      TextField(
                                                                    controller:
                                                                        _remarkController,
                                                                    autofocus:
                                                                        true,
                                                                    // ... additional text field properties ...
                                                                  ),
                                                                );
                                                              });
                                                        }),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: IconButton(
                                                    icon: Icon(Icons.delete),
                                                    onPressed: () {
                                                      setState(() {
                                                        myDiagnosis
                                                            .remove(element);
                                                        sumDuration = myDiagnosis.fold(
                                                            0,
                                                            (int sum,
                                                                    DiagnosisModule
                                                                        diagnosis) =>
                                                                sum +
                                                                diagnosis
                                                                    .duration);
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      );
                                    }),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Text(
                                    'Total Estimate Duration: $sumDuration Mins'),
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
                              onPressed: isLoading ? null : saveData,
                              child: Row(
                                children: [
                                  if (isLoading) // Show the circular progress indicator if isLoading is true
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                  Icon(Icons.save), // House icon
                                  Text('Save Diagnosis'), // Text widget
                                ],
                              ),
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
    _remarkController.dispose();
    super.dispose();
  }
}
