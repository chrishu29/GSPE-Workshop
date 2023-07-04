import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/dashboard/home_sreen.dart';
import 'package:gspe_mobile_workshop/src/feature/rma_customer/widget/detail_product_rr.dart';
import 'package:intl/intl.dart';

class RegisterRMA extends StatefulWidget {
  const RegisterRMA({super.key});

  @override
  State<RegisterRMA> createState() => _RegisterRMAState();
}

class _RegisterRMAState extends State<RegisterRMA> {
  TextEditingController _rmaController = TextEditingController();
  TextEditingController _entityNameController = TextEditingController();
  TextEditingController _customerNameController = TextEditingController();
  TextEditingController _siteNameController = TextEditingController();

  String _selectedOption = '';
  String _selectedOption2 = '';
  DateTime? _selectedDate;

  List<String> _options = [
    'Option 1',
    'Option 2',
    'Option 3',
  ];

  List<String> _entityType = [
    'Entity Type 1',
    'Entity Type 2',
    'Entity Type 3',
  ];

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
  Widget build(BuildContext context) {
    _selectedOption = _options[0];
    _selectedOption2 = _entityType[0];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
                child: SizedBox(
              height: 700,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.flag),
                        const SizedBox(height: 5),
                        Text('Return Material Authorization'),
                      ],
                    ),
                    TextField(
                      controller: _rmaController,
                      decoration: InputDecoration(labelText: 'RMA#'),
                    ),
                    DropdownButtonFormField(
                      value: _selectedOption,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedOption = newValue!;
                        });
                      },
                      items: _options.map<DropdownMenuItem<String>>((option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      decoration:
                          InputDecoration(labelText: 'Handover Document#'),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_selectedDate == null
                            ? 'Select Date'
                            : DateFormat('dd-MM-yyyy').format(_selectedDate!)),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Text('Date In'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField(
                      value: _selectedOption2,
                      onChanged: (newValues) {
                        setState(() {
                          _selectedOption2 = newValues!;
                        });
                      },
                      items:
                          _entityType.map<DropdownMenuItem<String>>((entity) {
                        return DropdownMenuItem(
                          value: entity,
                          child: Text(entity),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Entity Type',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _entityNameController,
                      decoration: InputDecoration(labelText: 'Entity Name'),
                    ),
                    TextField(
                      controller: _customerNameController,
                      decoration: InputDecoration(labelText: 'Customer Name'),
                      obscureText: true,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _siteNameController,
                      decoration: InputDecoration(labelText: 'Site Name'),
                      obscureText: true,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Perform registration logic here
                        String rma = _rmaController.text;
                        String entity = _entityNameController.text;
                        String customerName = _customerNameController.text;
                        String siteName = _siteNameController.text;
                        String selectedOption = _selectedOption;
                        String selectedOption2 = _selectedOption2;
                        DateTime? selectedDate = _selectedDate;

                        // Validate inputs, perform registration, etc.

                        // print('Registration button pressed');
                        // print('RMA: $rma');
                        // print('Entity Name: $entity');
                        // print('Customer Name: $customerName');
                        // print('Site Name: $siteName');
                        // print('Handover Document: $selectedOption');
                        // print('Entity Type: $selectedOption2');
                        // print('Date In: $selectedDate');

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
            )),
            //Table for Detail Product From RR
            Card(
                child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.stacked_bar_chart),
                    Text('Detail Product From RR'),
                  ],
                ),
                DetailsProductFromRR.table(),
              ],
            )),
            //table for Serial Number
            Card(
                child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.stacked_bar_chart),
                    Text('Serial Number'),
                  ],
                ),
                DetailsProductFromRR.table(),
              ],
            )),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _rmaController.dispose();
    _entityNameController.dispose();
    _customerNameController.dispose();
    _siteNameController.dispose();
    super.dispose();
  }
}
