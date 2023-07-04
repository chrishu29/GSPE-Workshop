import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/reporting/widget/subMenuReport.dart';

class ReportingSubMenu extends StatelessWidget {
  const ReportingSubMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: SubMenuReporting.listMenu()),
      ],
    );
  }
}
