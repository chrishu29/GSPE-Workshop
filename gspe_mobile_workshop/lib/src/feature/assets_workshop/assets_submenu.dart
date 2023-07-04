import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/assets_workshop/widget/submenu.dart';

class AssetSubMenu extends StatelessWidget {
  const AssetSubMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: SubMenu.listMenu()),
      ],
    );
  }
}
