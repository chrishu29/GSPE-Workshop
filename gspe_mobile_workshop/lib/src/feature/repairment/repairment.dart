import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gspe_mobile_workshop/src/feature/dashboard/home_sreen.dart';
import 'package:gspe_mobile_workshop/src/feature/diagnosis/model/diagnosis_matrix_model.dart';
import 'package:gspe_mobile_workshop/src/feature/diagnosis/model/diagnosis_module_model.dart';
import 'package:gspe_mobile_workshop/src/feature/diagnosis/provider/diagnosis_matrix_provider.dart';
import 'package:gspe_mobile_workshop/src/feature/repairment/model/inventoryPart_module.dart';
import 'package:gspe_mobile_workshop/src/feature/repairment/model/partInventory_model.dart';
import 'package:gspe_mobile_workshop/src/feature/repairment/provider/partInventory_provider.dart';
import 'package:gspe_mobile_workshop/src/feature/repairment/provider/repairDetail_provider.dart';
import 'package:gspe_mobile_workshop/src/feature/repairment/provider/repairList_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class RepairmentDashboard extends StatefulWidget {
  const RepairmentDashboard({super.key});

  @override
  State<RepairmentDashboard> createState() => _RepairmentDashboardState();
}

class _RepairmentDashboardState extends State<RepairmentDashboard> {
  TextEditingController _partNameController = TextEditingController();
  TextEditingController _partDescController = TextEditingController();
  TextEditingController _manufacturerController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  TextEditingController _estDurationController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();
  TextEditingController _reqQtyController = TextEditingController();

  String _repairableOptions = '';
  String _selectedSerialNum = '';
  String _selectedFaultyDiagnosis = '';
  String selectedRepairSerial = '';
  int sumDuration = 0;
  int diagDetailId = 0;
  int proId = 0;
  int id = 0;
  DateTime? _startRepairDate;
  DateTime? _endRepairDate;
  bool isLoading = false;
  List<DiagnosisModule> myDiagnosis = [];
  List<PartModule> selectedInventoryPart = [];
  List<String> OldDescription = [];
  List<int> OldDuration = [];
  List<String> OldRemarks = [];
  List<int> OldMatrixId = [];
  List<int> OldDiagnosisMatrixId = [];
  int OldRepairStatus = 0;

  List<String> _options = [
    'Outstanding',
    'Done',
    'Failed',
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

  void saveData() async {
    // Set isLoading to true to show the progress indicator
    setState(() {
      isLoading = true;
    });

    RepairDetailProvider repairdetaildata = RepairDetailProvider();
    int repairable = 0;

    // To throw away the 00:00:00 at the end of the deadline
    int lastSpaceIndex = _startRepairDate.toString().lastIndexOf(' ');
    String trimmedStartRepair =
        _startRepairDate.toString().substring(0, lastSpaceIndex);

    int lastSpaceIndexEnd = _endRepairDate.toString().lastIndexOf(' ');
    String trimmedEndRepair =
        _endRepairDate.toString().substring(0, lastSpaceIndexEnd);

    if (_repairableOptions == "Outstanding") {
      repairable = 0;
    } else if (_repairableOptions == "Done") {
      repairable = 1;
    } else {
      repairable = 2;
    }

    // Map each value from the form
    Map<String, dynamic> postData = {
      "diagnosis_detail_id": diagDetailId,
      "product_id": proId,
      "id": id,
      "repairable": OldRepairStatus,
      "repair_start_date": trimmedStartRepair.toString(),
      "repair_end_date": trimmedEndRepair.toString(),
      "desc": [],
      "duration": [],
      "remark": [],
      "matrix_id": [],
      "diagnosis_matrix_id": [],
      "repair_status": [OldRepairStatus],
      "repair_statusNew": [repairable],
      "descNew": [],
      "durationNew": [],
      "remarkNew": [],
      "matrix_idNew": [],
      "product_id_replace": [],
      "qty_req": [],
    };

    for (var oldDesc in OldDescription) {
      String description = oldDesc;
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
    }

    for (var oldDura in OldDuration) {
      postData["duration"].add(oldDura);
    }

    for (var oldRem in OldRemarks) {
      postData["remark"].add(oldRem.toString());
    }

    for (var oldMID in OldMatrixId) {
      postData["matrix_id"].add(oldMID);
    }

    for (var oldDMatrixId in OldDiagnosisMatrixId) {
      postData["diagnosis_matrix_id"].add(oldDMatrixId);
    }

    for (var myDiag in myDiagnosis) {
      String description = myDiag.description;
      RegExp regex = RegExp(
          r'\((.*?)\)'); // Regular expression to match the text inside parentheses
      RegExpMatch? match = regex.firstMatch(description);

      if (match != null) {
        String valueInParentheses =
            match.group(1)!; // Get the value inside parentheses

        String modifiedValue = valueInParentheses.toUpperCase() +
            " REPAIR"; // Append " Repair" to the extracted value

        postData["descNew"].add(modifiedValue);
      } else {
        postData["descNew"].add(
            description); // If no parentheses found, add the original description
      }
      postData["durationNew"].add(myDiag.duration);
      postData["remarkNew"].add(myDiag.remarks);
      postData["matrix_idNew"].add(myDiag.matrixId);
    }

    for (var selectedInven in selectedInventoryPart) {
      postData["product_id_replace"].add(selectedInven.id);
      postData["qty_req"].add(selectedInven.reqQty);
    }

    print(postData);

    try {
      // Make a POST request to the API
      Uri apiUrl = Uri.parse("http://workshop.iotech.my.id/api/save-repair");
      var response = await http.post(
        apiUrl,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(postData),
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
        context.read<RepairListProvider>().getAllData();
        context.read<RepairDetailProvider>().getAllData();
        context.read<PartInventoryProvider>().getAllData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final repairDetailProvider = RepairDetailProvider();
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Card(
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
                              Text('Repairment Update'),
                            ],
                          ),
                          SizedBox(height: 16),
                          Consumer<RepairDetailProvider>(
                            builder: (context, repairDetailProvider, _) {
                              return Consumer<RepairListProvider>(
                                builder: (context, repairListProvider, _) {
                                  return DropdownButtonFormField(
                                    value: repairListProvider.Data.isEmpty
                                        ? null
                                        : repairListProvider.Data[0].serialNum
                                            .toString(),
                                    onChanged: (newValues) async {
                                      //assigned the selected serial number
                                      _selectedSerialNum = newValues!;
                                      final selectedSerial =
                                          repairListProvider.Data.firstWhere(
                                        (repairList) =>
                                            repairList.serialNum ==
                                            _selectedSerialNum,
                                      );

                                      // Call the setSelectedRepairSerial method with the selected serial number
                                      repairDetailProvider
                                          .setSelectedRepairSerial(
                                              selectedSerial.serialNum);

                                      // Fetch and save all the data from the API
                                      await repairDetailProvider.getAllData();

                                      // Access the repair detail data
                                      final repairDetailData =
                                          repairDetailProvider.Data;

                                      // Assign values to the controllers using the data
                                      //assign part name
                                      _partNameController.text =
                                          repairDetailData.isEmpty
                                              ? ''
                                              : repairDetailData[0]
                                                  .products
                                                  .partName;
                                      //assign part description
                                      _partDescController.text =
                                          repairDetailData.isEmpty
                                              ? ''
                                              : repairDetailData[0]
                                                  .products
                                                  .partDesc;
                                      //assign part mfr
                                      _manufacturerController.text =
                                          repairDetailData.isEmpty
                                              ? ''
                                              : repairDetailData[0]
                                                  .products
                                                  .mfr;
                                      //assign estimated duration
                                      _estDurationController.text =
                                          repairDetailData.isEmpty
                                              ? ''
                                              : repairDetailData[0]
                                                  .duration
                                                  .toString();
                                      //assign repairable
                                      _repairableOptions = repairDetailData
                                              .isEmpty
                                          ? ''
                                          : repairDetailData[0].isRepairable ==
                                                  0
                                              ? 'Outstanding'
                                              : repairDetailData[0]
                                                          .isRepairable ==
                                                      1
                                                  ? 'Done'
                                                  : 'Failed';
                                      OldRepairStatus =
                                          repairDetailData[0].isRepairable;
                                      //assign start repair date
                                      _startRepairDate =
                                          repairDetailData[0].repairStartDate;
                                      //assign end repair date
                                      _endRepairDate =
                                          repairDetailData[0].repairEndDate;

                                      diagDetailId = repairDetailData[0].id;
                                      proId = repairDetailData[0].productId;
                                      id = repairDetailData[0].id;

                                      //add old diagnosis
                                      for (var mDiag in repairDetailData[0]
                                          .matrixDiagnosis) {
                                        DiagnosisModule oldDiagnoze =
                                            DiagnosisModule(
                                                description: mDiag.desc.name,
                                                duration: mDiag.desc.duration,
                                                remarks: mDiag.remark,
                                                matrixId:
                                                    mDiag.diagnosisMatrixId);
                                        myDiagnosis.add(oldDiagnoze);
                                        OldDescription.add(mDiag.desc.name);
                                        OldDuration.add(mDiag.duration);
                                        OldRemarks.add(mDiag.remark);
                                        OldMatrixId.add(mDiag.id);
                                        OldDiagnosisMatrixId.add(
                                            mDiag.diagnosisMatrixId);
                                        OldRepairStatus = mDiag.status;
                                      }

                                      setState(() {
                                        // Perform any additional UI updates if necessary
                                      });
                                    },
                                    items: repairListProvider.Data.map<
                                        DropdownMenuItem<String>>(
                                      (serNum) {
                                        return DropdownMenuItem(
                                          value: serNum.serialNum.toString(),
                                          child: Text('${serNum.serialNum}'),
                                        );
                                      },
                                    ).toList(),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  );
                                },
                              );
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
                                : _repairableOptions == 'Outstanding'
                                    ? _options[0]
                                    : _repairableOptions == 'Done'
                                        ? _options[1]
                                        : _options[2],
                            onChanged: (newValues) {
                              setState(() {
                                _repairableOptions = newValues!;
                              });
                            },
                            items: _options
                                .map<DropdownMenuItem<String>>((rapair) {
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
                          Column(
                            children: [
                              Text('Estimated Duration (Mins)'),
                              TextField(
                                controller: _estDurationController,
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
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.storage),
                                      const SizedBox(width: 5),
                                      Text('Diagnosis Result'),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    children: [
                                      Text('Add Faulty Diagnosis Matrix :'),
                                      Consumer<DiagMatrixProvider>(
                                          builder: (context, dm, _) {
                                        return DropdownButtonFormField(
                                          value: dm.allData.isEmpty
                                              ? Null
                                              : dm.allData[0].name,
                                          onChanged: (newValues) {
                                            _selectedFaultyDiagnosis =
                                                newValues as String;
                                            final selectedMatrix =
                                                dm.allData.firstWhere(
                                              (dmatrix) =>
                                                  dmatrix.name ==
                                                  _selectedFaultyDiagnosis,
                                              orElse: () => DiagnosisMatrix(
                                                  id: 0,
                                                  name: '-',
                                                  level: '-',
                                                  duration: 0,
                                                  created_at: '-',
                                                  updated_at: '-'),
                                            );
                                            //need to check and change the estimated duration of the diagnosis faulty to be editable
                                            setState(() {
                                              DiagnosisModule diagnoze =
                                                  DiagnosisModule(
                                                      description: newValues,
                                                      duration: selectedMatrix
                                                          .duration,
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
                                              _estDurationController.text =
                                                  sumDuration.toString();
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
                                  //Diagnosis result Table
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
                                                        _estDurationController
                                                                .text =
                                                            sumDuration
                                                                .toString();
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Card(
                              child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.stacked_bar_chart),
                                    const SizedBox(height: 5),
                                    Text('Replacement Part'),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Consumer<PartInventoryProvider>(
                                    builder: (context, pi, _) {
                                  final namePart = pi.allData;
                                  return TypeAheadField(
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                            controller: _searchController,
                                            decoration: InputDecoration(
                                              hintText:
                                                  'Search Part in Inventory',
                                              prefixIcon: Icon(Icons.search),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            )),
                                    suggestionsCallback: (pattern) {
                                      return pi.getSuggestions(pattern);
                                    },
                                    itemBuilder: (context, suggestion) {
                                      return ListTile(
                                        title: Text(suggestion.toString()),
                                      );
                                    },
                                    onSuggestionSelected: (suggestion) {
                                      _searchController.text = suggestion;
                                      final selectedPart = namePart.firstWhere(
                                        (pName) => pName.partName == suggestion,
                                        orElse: () => PartInventory(
                                            id: 0,
                                            partName: '-',
                                            partNum: '-',
                                            partDesc: '-',
                                            mfr: '-',
                                            qty: 0,
                                            defaultUm: '-'),
                                      );
                                      if (selectedPart.id != 0) {
                                        // Add the selected data to the list
                                        selectedInventoryPart.add(PartModule(
                                            id: selectedPart.id,
                                            mfr: selectedPart.mfr,
                                            partNum: selectedPart.partNum,
                                            partName: selectedPart.partName,
                                            partDesc: selectedPart.partDesc,
                                            qty: selectedPart.qty,
                                            reqQty: 0,
                                            defaultUm: selectedPart.defaultUm));
                                        setState(() {});
                                      }
                                    },
                                  );
                                }),
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
                                        3: FlexColumnWidth(2),
                                        4: FlexColumnWidth(2),
                                        5: FlexColumnWidth(2),
                                        6: FlexColumnWidth(2),
                                        7: FlexColumnWidth(2),
                                        8: FlexColumnWidth(2),
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
                                                'id',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                            ),
                                            TableCell(
                                              child: Center(
                                                  child: Text(
                                                'Mfr',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                            ),
                                            TableCell(
                                              child: Center(
                                                  child: Text(
                                                'Part Number',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                            ),
                                            TableCell(
                                              child: Center(
                                                  child: Text(
                                                'Part Name',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                            ),
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
                                                'U/M',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                            ),
                                            TableCell(
                                              child: Center(
                                                  child: Text(
                                                'Qty in Stock',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                            ),
                                            TableCell(
                                              child: Center(
                                                  child: Text(
                                                'Qty Request',
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
                                              )),
                                            ),
                                          ],
                                        ),
                                        for (var elements
                                            in selectedInventoryPart)
                                          TableRow(
                                            children: [
                                              TableCell(
                                                child: Center(
                                                    child: Text(
                                                  elements.id.toString(),
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                )),
                                              ),
                                              TableCell(
                                                child: Center(
                                                    child: Text(
                                                  elements.mfr,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                )),
                                              ),
                                              TableCell(
                                                child: Center(
                                                    child: Text(
                                                  elements.partNum,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                )),
                                              ),
                                              TableCell(
                                                child: Center(
                                                    child: Text(
                                                  elements.partName,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                )),
                                              ),
                                              TableCell(
                                                child: Center(
                                                    child: Text(
                                                  elements.partDesc,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                )),
                                              ),
                                              TableCell(
                                                child: Center(
                                                    child: Text(
                                                  elements.defaultUm,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                )),
                                              ),
                                              TableCell(
                                                child: Center(
                                                    child: Text(
                                                  elements.qty.toString(),
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                )),
                                              ),
                                              TableCell(
                                                child: Center(
                                                  child: TextField(
                                                      controller:
                                                          TextEditingController(
                                                        text: elements.reqQty
                                                            .toString(),
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: elements
                                                                    .reqQty ==
                                                                0
                                                            ? 'Requested Quantity'
                                                            : elements.reqQty
                                                                .toString(),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        _reqQtyController =
                                                            TextEditingController(
                                                          text: elements.reqQty
                                                              .toString(),
                                                        );
                                                        _reqQtyController
                                                                .selection =
                                                            TextSelection
                                                                .fromPosition(
                                                          TextPosition(
                                                              offset: elements
                                                                  .reqQty
                                                                  .toString()
                                                                  .length),
                                                        );
                                                        elements.reqQty =
                                                            int.parse(
                                                                _reqQtyController
                                                                    .text);
                                                        _reqQtyController
                                                            .addListener(() {
                                                          elements.reqQty =
                                                              int.parse(
                                                                  _reqQtyController
                                                                      .text);
                                                        });
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                content:
                                                                    TextField(
                                                                  controller:
                                                                      _reqQtyController,
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
                                                      selectedInventoryPart
                                                          .remove(elements);
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
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
                                child: Text('Start Repair'),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
