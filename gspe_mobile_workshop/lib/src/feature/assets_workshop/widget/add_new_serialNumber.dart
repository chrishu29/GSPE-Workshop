import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/assets_workshop/const_widget/asset_tables.dart';
import 'package:gspe_mobile_workshop/src/feature/assets_workshop/widget/asset_serial_number.dart';

class NewSerialNumber extends StatefulWidget {
  const NewSerialNumber({super.key});

  @override
  State<NewSerialNumber> createState() => _NewSerialNumberState();
}

class _NewSerialNumberState extends State<NewSerialNumber> {
  String _selectedDocument = '';

  List<String> _HandoverDoc = [
    '251/Log/VII/20222520',
    '251/Log/VII/20222521',
    '251/Log/VII/20222522',
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.flag),
                        const SizedBox(height: 5),
                        Text('Add Serial Number'),
                      ],
                    ),
                    DropdownButtonFormField(
                      value: _HandoverDoc.first,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedDocument = newValue!;
                        });
                      },
                      items: _HandoverDoc.map<DropdownMenuItem<String>>((doc) {
                        return DropdownMenuItem(
                          value: doc,
                          child: Text(doc),
                        );
                      }).toList(),
                      decoration:
                          InputDecoration(labelText: 'Handover Document#'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Perform registration logic here
                        String handoverDoc = _selectedDocument;

                        // Validate inputs, perform registration, etc.

                        print('Save button pressed');
                        print('Handover Document: $handoverDoc');

                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const AssetSerialNumber()),
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

  // @override
  // void dispose() {
  //   _referenceProjectController.dispose();
  //   _reqDocController.dispose();
  //   _purposeController.dispose();
  //   _remarkController.dispose();
  //   super.dispose();
  // }
}
