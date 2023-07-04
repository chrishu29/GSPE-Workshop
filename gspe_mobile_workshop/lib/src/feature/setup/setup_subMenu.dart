import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/setup/widget/subMenuSetup.dart';

class SetupSubMenu extends StatelessWidget {
  const SetupSubMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: SubMenuSetup.listMenu()),
      ],
    );
  }
}
