import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/transaction/widget/subMenu.dart';

class TransactionSubMenu extends StatelessWidget {
  const TransactionSubMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: TransactionsSubMenu.listMenu()),
      ],
    );
  }
}
