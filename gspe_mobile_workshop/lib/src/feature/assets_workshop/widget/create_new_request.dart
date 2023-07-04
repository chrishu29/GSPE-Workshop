import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/assets_workshop/const_widget/asset_tables.dart';
import 'package:gspe_mobile_workshop/src/feature/assets_workshop/widget/asset_inventory.dart';
import 'package:intl/intl.dart';

class NewInventoryRequest extends StatefulWidget {
  const NewInventoryRequest({super.key});

  @override
  State<NewInventoryRequest> createState() => _NewInventoryRequestState();
}

class _NewInventoryRequestState extends State<NewInventoryRequest> {
  TextEditingController _reqDocController = TextEditingController();
  TextEditingController _referenceProjectController = TextEditingController();
  TextEditingController _purposeController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();

  String _selectedOption = '';
  DateTime? _requestDate;

  List<String> _requestBy = [
    'Requestor 1',
    'Requestor 2',
    'Requestor 3',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _requestDate) {
      setState(() {
        _requestDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
                child: SizedBox(
              height: 1000,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.flag),
                        const SizedBox(height: 5),
                        Text('Entry New Inventory Request'),
                      ],
                    ),
                    TextField(
                      controller: _reqDocController,
                      decoration: InputDecoration(labelText: 'Request Doc#'),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_requestDate == null
                            ? 'Select Date'
                            : DateFormat('dd-MM-yyyy').format(_requestDate!)),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Text('Request Date'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField(
                      value: _requestBy.first,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedOption = newValue!;
                        });
                      },
                      items:
                          _requestBy.map<DropdownMenuItem<String>>((requestor) {
                        return DropdownMenuItem(
                          value: requestor,
                          child: Text(requestor),
                        );
                      }).toList(),
                      decoration: InputDecoration(labelText: 'Request By#'),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _referenceProjectController,
                      decoration: InputDecoration(
                          labelText: 'Reference Project (Optional)'),
                    ),
                    TextField(
                      controller: _purposeController,
                      decoration: InputDecoration(labelText: 'Purpose'),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _remarkController,
                      decoration: InputDecoration(labelText: 'Remark'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Perform registration logic here
                        String reqDoc = _reqDocController.text;
                        String referenceProj = _referenceProjectController.text;
                        String purpose = _purposeController.text;
                        String remark = _remarkController.text;
                        String requestBy = _selectedOption;
                        DateTime? selectedDate = _requestDate;

                        // Validate inputs, perform registration, etc.

                        print('Registration button pressed');
                        print('RMA: $reqDoc');
                        print('Entity Name: $referenceProj');
                        print('Customer Name: $purpose');
                        print('Site Name: $remark');
                        print('Handover Document: $requestBy');
                        print('Date In: $selectedDate');

                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const AssetInventory()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            )),
            //Table for Detail Product From RR
            Card(
                child: Column(
              children: [
                // Row(
                //   children: [
                //     Icon(Icons.stacked_bar_chart),
                //     Text('Detail Product From RR'),
                //   ],
                // ),
                AssetTables.table(),
              ],
            )),
            //table for Serial Number
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
    _referenceProjectController.dispose();
    _reqDocController.dispose();
    _purposeController.dispose();
    _remarkController.dispose();
    super.dispose();
  }
}
