import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/apps.dart';
import 'package:gspe_mobile_workshop/src/feature/auth/view/login_screen.dart';
import 'package:gspe_mobile_workshop/src/feature/diagnosis/provider/diagnosis_matrix_provider.dart';
import 'package:gspe_mobile_workshop/src/feature/diagnosis/provider/serial_number_provider.dart';
import 'package:gspe_mobile_workshop/src/feature/repairment/provider/partInventory_provider.dart';
import 'package:gspe_mobile_workshop/src/feature/repairment/provider/repairDetail_provider.dart';
import 'package:gspe_mobile_workshop/src/feature/repairment/provider/repairList_provider.dart';
// import 'package:gspe_mobile_workshop/src/state_manager/appstate.dart';
// import 'package:gspe_mobile_workshop/src/state_manager/btnstate.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => 
        MyApp(), // Wrap your app
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DiagMatrixProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RepairListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RepairDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PartInventoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SerialNumProvider(),
        ),
      ],
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Mobile Workshop',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: LoginPage(),
      ),
    );
  }
}
