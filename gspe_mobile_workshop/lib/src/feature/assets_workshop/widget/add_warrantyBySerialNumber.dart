import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/assets_workshop/const_widget/asset_tables.dart';
import 'package:gspe_mobile_workshop/src/feature/assets_workshop/widget/asset_inventory.dart';
import 'package:intl/intl.dart';

class AddWarrantybySerialNumber extends StatefulWidget {
  const AddWarrantybySerialNumber({super.key});

  @override
  State<AddWarrantybySerialNumber> createState() =>
      _AddWarrantybySerialNumberState();
}

class _AddWarrantybySerialNumberState extends State<AddWarrantybySerialNumber> {
  TextEditingController _reqDocController = TextEditingController();
  TextEditingController _referenceProjectController = TextEditingController();
  TextEditingController _purposeController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();

  String _selectedWType = '';
  String _selectedWPeriod = '';
  DateTime? _warrantyStartDate;

  List<String> _WarrantyType = [
    'Full(Barang + Service)',
    'Limited(Service)',
  ];

  List<String> _WarrantyPeriod = [
    '6 Months',
    '1 Year',
    '2 Year',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _warrantyStartDate) {
      setState(() {
        _warrantyStartDate = picked;
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
                        Text('Add Warranty by Serial Number'),
                      ],
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField(
                      value: _WarrantyType.first,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedWType = newValue!;
                        });
                      },
                      items: _WarrantyType.map<DropdownMenuItem<String>>(
                          (requestor) {
                        return DropdownMenuItem(
                          value: requestor,
                          child: Text(requestor),
                        );
                      }).toList(),
                      decoration: InputDecoration(labelText: 'Warranty Type#'),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField(
                      value: _WarrantyPeriod.first,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedWPeriod = newValue!;
                        });
                      },
                      items: _WarrantyPeriod.map<DropdownMenuItem<String>>(
                          (requestor) {
                        return DropdownMenuItem(
                          value: requestor,
                          child: Text(requestor),
                        );
                      }).toList(),
                      decoration:
                          InputDecoration(labelText: 'Warranty Period#'),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_warrantyStartDate == null
                            ? 'Select Date'
                            : DateFormat('dd-MM-yyyy')
                                .format(_warrantyStartDate!)),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Text('Warranty Start Date'),
                        ),
                      ],
                    ),
                    TextField(
                      controller: _remarkController,
                      decoration: InputDecoration(labelText: 'Remark'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Perform registration logic here
                        String remark = _remarkController.text;
                        String warrantyType = _selectedWType;
                        String warrantyPeriod = _selectedWPeriod;
                        DateTime? wStartDate = _warrantyStartDate;

                        // Validate inputs, perform registration, etc.

                        print('Registration button pressed');
                        print('Warranty Type: $warrantyType');
                        print('Warranty Period: $warrantyPeriod');
                        print('Site Name: $remark');
                        print('Warranty Start Date: $wStartDate');

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
