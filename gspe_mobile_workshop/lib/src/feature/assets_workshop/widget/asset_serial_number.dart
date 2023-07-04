import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/assets_workshop/assets_submenu.dart';
import 'package:gspe_mobile_workshop/src/feature/assets_workshop/const_widget/asset_search.dart';
import 'package:gspe_mobile_workshop/src/feature/assets_workshop/const_widget/asset_tables.dart';
import 'package:gspe_mobile_workshop/src/feature/assets_workshop/widget/add_new_serialNumber.dart';

class AssetSerialNumber extends StatelessWidget {
  const AssetSerialNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.flag),
                        Text(
                          'Serial Number',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          Future.delayed(const Duration(milliseconds: 200), () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NewSerialNumber()),
                              (Route<dynamic> route) => false,
                            );
                          });
                        },
                        icon: Icon(Icons.remove_from_queue),
                        label: Text('Add Serial Number')),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Find Serial Number',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    AssetSearchBar(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: AssetTables.table(),
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      Future.delayed(const Duration(milliseconds: 200), () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const AssetSubMenu()),
                          (Route<dynamic> route) => false,
                        );
                      });
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text('Back to Menu')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
